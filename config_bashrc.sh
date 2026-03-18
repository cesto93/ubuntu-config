#!/bin/bash

# Define the lines to be added
LINES_TO_ADD='
# Add local bin
export PATH="$HOME/.local/bin:$PATH"

# Add go bin
export PATH=$PATH:$(go env GOPATH)/bin

. "$HOME/.cargo/env"
'

# Append the lines to .bashrc
echo "$LINES_TO_ADD" >> ~/.bashrc

# Notify the user
echo "The lines have been added to ~/.bashrc. Please restart your terminal or run 'source ~/.bashrc' to apply the changes."
