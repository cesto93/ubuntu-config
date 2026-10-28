#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

OUT_DIR="package_lists"
mkdir -p "$OUT_DIR"

# Manually installed packages only (excludes auto-installed dependencies)
apt-mark showmanual > "$OUT_DIR/apt_list.txt"

flatpak list --app --columns=application > "$OUT_DIR/flatpak_list.txt"

# Snap packages: name + tracking channel only
snap list | awk 'NR > 1 { print $1, $4 }' > "$OUT_DIR/snap_list.txt"
