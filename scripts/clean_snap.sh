#!/bin/bash
# Removals of old revisions of snaps
# Close all snaps before running this

set -eu

snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        echo "Removing $snapname revision $revision..."
        snap remove "$snapname" --revision="$revision"
    done

echo "Clean-up complete!"
