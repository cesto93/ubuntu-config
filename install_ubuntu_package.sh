#!/bin/bash

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STOW_DIR="$SCRIPT_DIR/dotfiles"

PACKAGE=$1

if [ -z "$PACKAGE" ]; then
    echo "Usage: $0 <package>"
    echo "Available packages: brew, tmux, nvim, zed, latex, plantuml, go, llamacpp, rust, opencode"
    exit 1
fi

stow_pkg() {
    local pkg=$1
    stow -d "$STOW_DIR" -t "$HOME" "$pkg"
}

case $PACKAGE in
    brew)
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo -e "\n# Homebrew\nexport PATH=\"/home/linuxbrew/.linuxbrew/bin:\$PATH\"" >> ~/.bashrc
        echo "The lines have been added to ~/.bashrc. Please restart your terminal or run 'source ~/.bashrc' to apply the changes."
        ;;
    tmux)
        echo "Configuring tmux..."
        stow_pkg tmux
        echo "Installing fzf dependency..."
        sudo apt update && sudo apt install -y fzf
        cat << 'EOF' >> ~/.bashrc

# tmux variables
export TSESH_DIRS="$HOME/repos/ "
if [[ -n "$TMUX" ]]; then
    tmux set-environment -g TSESH_DIRS "$TSESH_DIRS"
fi
EOF
        echo "The lines have been added to ~/.bashrc. Please restart your terminal or run 'source ~/.bashrc' to apply the changes."
        ;;
    nvim)
        echo "Installing nvim via snap..."
        sudo snap install nvim --classic
        echo "Installing fzf dependency..."
        sudo apt update && sudo apt install -y fzf
        echo "Installing gcc dependency..."
        sudo apt install -y gcc
        echo "Installing tree-sitter-cli dependency..."
        brew install tree-sitter-cli
        stow_pkg nvim
        ;;
    zed)
        echo "Configuring zed..."
        stow_pkg zed
        ;;
    latex)
        echo "Installing LaTeX and Pandoc..."
        # Note: Correcting 'textlive-full' to 'texlive-full' from original script
        sudo apt update && sudo apt install -y texlive-full pandoc
        ;;
    plantuml)
        echo "Installing PlantUML dependencies..."
        sudo apt update && sudo apt install -y graphviz
        stow_pkg local
        echo "PlantUML script symlinked to ~/.local/bin/plantuml.sh"
        ;;
    go)
        echo "Installing Go via snap..."
        sudo snap install go --classic
        echo "Installing goplantuml..."
        sudo go install github.com/jfeliu007/goplantuml/cmd/goplantuml@latest
    echo "Installing gopls..."
    go install golang.org/x/tools/gopls@latest
    echo -e "\n# Go\nexport PATH=\"\$HOME/go/bin:\$PATH\"" >> ~/.bashrc
    echo "The lines have been added to ~/.bashrc. Please restart your terminal or run 'source ~/.bashrc' to apply the changes."
    ;;
    llamacpp)
        echo "Installing llama.cpp via brew..."
        brew install llama.cpp
        ;;
    rust)
        echo "Installing rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        ;;
    opencode)
        echo "Configuring opencode..."
        stow_pkg opencode
        ;;
    *)
        echo "Unknown package: $PACKAGE"
        echo "Available packages: brew, tmux, nvim, zed, latex, plantuml, go, llamacpp, rust, opencode"
        exit 1
        ;;
esac
