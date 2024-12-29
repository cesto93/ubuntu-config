#!/bin/bash

sudo snap install nvim go --classic

sudo apt install fzf textlive-full

# goplantuml
sudo go install go install github.com/jfeliu007/goplantuml/cmd/goplantuml@latest

mkdir -p ~/.config/tmux/
cp -r tmux/* ~/.config/tmux/
