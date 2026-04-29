#!/bin/bash

PACKAGE=$1

if [ -z "$PACKAGE" ]; then
    echo "Usage: $0 <package>"
    echo "Available packages: nvim, latex, plantuml, go, llamacpp"
    exit 1
fi

case $PACKAGE in
    nvim)
        echo "Installing nvim via snap..."
        sudo snap install nvim --classic
        echo "Installing fzf dependency..."
        sudo apt update && sudo apt install -y fzf
        ;;
    latex)
        echo "Installing LaTeX and Pandoc..."
        # Note: Correcting 'textlive-full' to 'texlive-full' from original script
        sudo apt update && sudo apt install -y texlive-full pandoc
        ;;
    plantuml)
        echo "Installing PlantUML dependencies..."
        sudo apt update && sudo apt install -y graphviz
        mkdir -p /home/pier/.local/bin
        cp scripts/plantuml.sh /home/pier/.local/bin/plantuml.sh
        chmod +x /home/pier/.local/bin/plantuml.sh
        echo "PlantUML script copied to /home/pier/.local/bin/plantuml.sh"
        ;;
    go)
        echo "Installing Go via snap..."
        sudo snap install go --classic
        echo "Installing goplantuml..."
        sudo go install github.com/jfeliu007/goplantuml/cmd/goplantuml@latest
        echo "Installing gopls..."
        go install golang.org/x/tools/gopls@latest
        ;;
    llamacpp)
        echo "Installing llama.cpp via brew..."
        brew install llama.cpp
        ;;
    *)
        echo "Unknown package: $PACKAGE"
        echo "Available packages: nvim, latex, plantuml, go, llamacpp"
        exit 1
        ;;
esac
