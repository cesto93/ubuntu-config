#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_FILE="$SCRIPT_DIR/../zed/settings.json"
CONFIG_FILE="$HOME/.config/zed/settings.json"

usage() {
    echo "Usage: $0 {push|pull}"
    echo "  push  Copy zed/settings.json from the repo to ~/.config/zed/settings.json"
    echo "  pull  Copy ~/.config/zed/settings.json from your machine to the repo"
    exit 1
}

if [ "$#" -ne 1 ]; then
    usage
fi

case "$1" in
    push)
        if [ ! -f "$REPO_FILE" ]; then
            echo "Error: $REPO_FILE not found"
            exit 1
        fi
        mkdir -p "$(dirname "$CONFIG_FILE")"
        cp "$REPO_FILE" "$CONFIG_FILE"
        echo "Pushed zed settings to $CONFIG_FILE"
        ;;
    pull)
        if [ ! -f "$CONFIG_FILE" ]; then
            echo "Error: $CONFIG_FILE not found"
            exit 1
        fi
        cp "$CONFIG_FILE" "$REPO_FILE"
        echo "Pulled zed settings to $REPO_FILE"
        ;;
    *)
        usage
        ;;
esac
