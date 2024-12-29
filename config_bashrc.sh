#!/bin/bash

# Define the lines to be added
LINES_TO_ADD='
#CUSTOM pier
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:$(go env GOPATH)/bin
. "$HOME/.cargo/env"

#Pier alias
alias codium="flatpak run com.vscodium.codium"
alias obsidian="flatpak run md.obsidian.Obsidian"

# tmux variables
export TSESH_DIRS="$HOME/Desktop/repos/ "
if [[ -n "$TMUX" ]]; then
    tmux set-environment -g TSESH_DIRS "$TSESH_DIRS"
fi
'

# Append the lines to .bashrc
echo "$LINES_TO_ADD" >> ~/.bashrc

# Notify the user
echo "The lines have been added to ~/.bashrc. Please restart your terminal or run 'source ~/.bashrc' to apply the changes."
