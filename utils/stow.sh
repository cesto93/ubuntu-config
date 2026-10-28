#!/bin/bash

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STOW_DIR="$SCRIPT_DIR/../dotfiles"
PACKAGES=(nvim tmux zed opencode local)

usage() {
    echo "Usage: $0 {push|pull|delete}"
    echo "  push    Adopt live config changes into the repo (stow --adopt), then git add -A"
    echo "  pull    Ensure symlinks exist from the repo to the target (stow)"
    echo "  delete  Remove stow symlinks from the target (stow -D)"
    exit 1
}

if [ "$#" -ne 1 ]; then
    usage
fi

case "$1" in
    push)
        stow -d "$STOW_DIR" -t "$HOME" --adopt "${PACKAGES[@]}"
        git -C "$SCRIPT_DIR/.." add -A
        echo "Adopted live config. Review the diff before committing."
        ;;
    pull)
        stow -d "$STOW_DIR" -t "$HOME" "${PACKAGES[@]}"
        echo "Symlinks ensured for: ${PACKAGES[*]}"
        ;;
    delete)
        stow -d "$STOW_DIR" -t "$HOME" -D "${PACKAGES[@]}"
        echo "Removed symlinks for: ${PACKAGES[*]}"
        ;;
    *)
        usage
        ;;
esac