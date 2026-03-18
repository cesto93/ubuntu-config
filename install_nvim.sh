#!/bin/bash

echo "Install nvim via snap"
sudo snap install nvim --classic

echo "Install fuzzi finder dependency for nvim scripts"
sudo apt install fzf
