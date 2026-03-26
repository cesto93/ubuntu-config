#!/bin/bash

# Define the lines to be added
LINES_TO_ADD='
# Homebrew
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
'

# Append the lines to .bashrc
echo "$LINES_TO_ADD" >> ~/.bashrc

# Notify the user
echo "The lines have been added to ~/.bashrc. Please restart your terminal or run 'source ~/.bashrc' to apply the changes."
