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

sudo flatpak update -y
