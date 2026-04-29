#!/bin/bash

# Exit on error
set -eu

clean_cache() {
    echo "Cleaning system cache (~/.cache/*)..."
    rm -rf ~/.cache/*
}

clean_gradle() {
    echo "Cleaning Gradle cache (~/.gradle/caches/*)..."
    rm -rf ~/.gradle/caches/*
}

clean_snap() {
    echo "Cleaning old snap revisions..."
    # Note: Close all snaps before running this
    if command -v snap > /dev/null; then
        snap list --all | awk '/disabled/{print $1, $3}' |
            while read snapname revision; do
                echo "Removing $snapname revision $revision..."
                snap remove "$snapname" --revision="$revision"
            done
    else
        echo "Error: 'snap' command not found."
        return 1
    fi
}

usage() {
    echo "Usage: $0 [cache] [gradle] [snap]"
    echo "Example: $0 cache gradle"
    exit 1
}

if [ $# -eq 0 ]; then
    usage
fi

for arg in "$@"; do
    case $arg in
        cache)
            clean_cache
            ;;
        gradle)
            clean_gradle
            ;;
        snap)
            clean_snap
            ;;
        *)
            echo "Warning: Unknown parameter '$arg'"
            usage
            ;;
    esac
done

echo "Clean-up tasks finished!"
