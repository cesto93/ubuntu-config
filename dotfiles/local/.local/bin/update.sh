#!/bin/bash

# System maintenance tasks. Privileged commands use sudo, so run this as a
# normal user (`update.sh`); sudo will prompt once up front.

set -eu

# Ask for sudo credentials once, so a mid-run prompt can't abort an upgrade.
sudo -v

sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

sudo snap refresh

if command -v flatpak > /dev/null 2>&1; then
    sudo flatpak update -y
else
    echo "Flatpak not installed; skipping flatpak update."
fi

# Homebrew is user-level and must NOT run as root.
update_brew() {
    local brew_bin
    if command -v brew > /dev/null 2>&1; then
        brew_bin="$(command -v brew)"
    elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
        brew_bin=/home/linuxbrew/.linuxbrew/bin/brew
    else
        echo "Homebrew not installed; skipping brew update."
        return 0
    fi

    "$brew_bin" update
    "$brew_bin" upgrade
}

update_brew
