#!/bin/bash
#
# Compress all PDFs in a directory using Ghostscript.
#
# Usage:
#   compress-pdfs.sh [DIRECTORY] [QUALITY]
#   compress-pdfs.sh [-q|--quality QUALITY] [DIRECTORY]
#   compress-pdfs.sh -h|--help
#
# Arguments:
#   DIRECTORY  Directory containing PDFs to compress (default: current directory).
#   QUALITY    Ghostscript PDFSETTINGS preset (default: ebook):
#                screen   - 72 dpi, smallest size, screen viewing only
#                ebook    - 150 dpi, good balance of size/quality
#                printer  - 300 dpi, high quality, larger size
#                prepress - 300 dpi, color preserving, largest size
#                default  - Ghostscript default (nearly no compression)
#
# Output:
#   Compressed files are written to <DIRECTORY>/compressed/<name>.pdf
#   Originals are left untouched.
#
# Example:
#   compress-pdfs.sh ~/Documents ebook
#   compress-pdfs.sh -q screen ~/Documents
#   compress-pdfs.sh --quality printer .

set -euo pipefail

QUALITY="ebook"
DIRECTORY="."

usage() {
    sed -n '2,26p' "$0" | sed 's/^# //; s/^#//'
    exit "${1:-0}"
}

# Parse args: support both positional and -q/--quality flags.
POSITIONAL=()
while [ "$#" -gt 0 ]; do
    case "$1" in
        -h|--help)
            usage 0
            ;;
        -q|--quality)
            if [ "$#" -lt 2 ]; then
                echo "Error: $1 requires a value." >&2
                usage 1
            fi
            QUALITY="$2"
            shift 2
            ;;
        -*)
            echo "Error: unknown option: $1" >&2
            usage 1
            ;;
        *)
            POSITIONAL+=("$1")
            shift
            ;;
    esac
done

# Support positional form: [DIRECTORY] [QUALITY]
if [ "${#POSITIONAL[@]}" -ge 1 ]; then
    DIRECTORY="${POSITIONAL[0]}"
fi
if [ "${#POSITIONAL[@]}" -ge 2 ]; then
    QUALITY="${POSITIONAL[1]}"
fi
if [ "${#POSITIONAL[@]}" -gt 2 ]; then
    echo "Error: too many arguments." >&2
    usage 1
fi

# Normalize quality: allow optional leading slash, case-insensitive.
QUALITY="$(echo "$QUALITY" | tr '[:upper:]' '[:lower:]' | sed 's|^\/*||')"

case "$QUALITY" in
    screen|ebook|printer|prepress|default)
        ;;
    *)
        echo "Error: invalid quality '$QUALITY'." >&2
        echo "Valid values: screen, ebook, printer, prepress, default." >&2
        exit 1
        ;;
esac

if ! command -v gs >/dev/null 2>&1; then
    echo "Error: Ghostscript (gs) not found. Install it with:" >&2
    echo "  sudo apt install ghostscript" >&2
    exit 1
fi

if [ ! -d "$DIRECTORY" ]; then
    echo "Error: directory not found: $DIRECTORY" >&2
    exit 1
fi

OUT_DIR="$DIRECTORY/compressed"
mkdir -p "$OUT_DIR"

shopt -s nullglob nocaseglob
PDFS=("$DIRECTORY"/*.pdf)
shopt -u nullglob nocaseglob

if [ "${#PDFS[@]}" -eq 0 ]; then
    echo "No PDF files found in $DIRECTORY"
    exit 0
fi

echo "Compressing ${#PDFS[@]} PDF(s) in '$DIRECTORY' with quality '/$QUALITY'..."
echo "Output directory: '$OUT_DIR'"
echo ""

SUCCESS=0
FAILED=0

for INPUT in "${PDFS[@]}"; do
    BASENAME="$(basename "$INPUT")"
    OUTPUT="$OUT_DIR/$BASENAME"

    # Skip files that are already our own output if DIRECTORY == OUT_DIR.
    if [ "$INPUT" -ef "$OUTPUT" ]; then
        continue
    fi

    echo "-> $BASENAME"
    if gs -sDEVICE=pdfwrite \
        -dCompatibilityLevel=1.4 \
        "-dPDFSETTINGS=/$QUALITY" \
        -dNOPAUSE -dQUIET -dBATCH \
        -sOutputFile="$OUTPUT" \
        "$INPUT"; then
        BEFORE="$(du -h "$INPUT" | cut -f1)"
        AFTER="$(du -h "$OUTPUT" | cut -f1)"
        echo "   done: $BEFORE -> $AFTER ($OUTPUT)"
        SUCCESS=$((SUCCESS + 1))
    else
        echo "   FAILED: $BASENAME" >&2
        FAILED=$((FAILED + 1))
    fi
done

echo ""
echo "Done: $SUCCESS succeeded, $FAILED failed."
[ "$FAILED" -eq 0 ]
