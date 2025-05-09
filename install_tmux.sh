#!/bin/bash

mkdir -p ~/.config/tmux/
cp -r tmux/* ~/.config/tmux/

#dependency
sudo apt install fzf


LINES_TO_ADD='
# tmux variables
export TSESH_DIRS="$HOME/repos/ "
if [[ -n "$TMUX" ]]; then
    tmux set-environment -g TSESH_DIRS "$TSESH_DIRS"
fi
'

# Append the lines to .bashrc
echo "$LINES_TO_ADD" >> ~/.bashrc

# Notify the user
echo "The lines have been added to ~/.bashrc. Please restart your terminal or run 'source ~/.bashrc' to apply the changes."
