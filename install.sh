#!/usr/bin/env bash

# install.sh — Install packages and applications via Homebrew

set -euo pipefail

# Xcode Command Line Tools (required by Homebrew and many packages)
if ! xcode-select -p &> /dev/null; then
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "Waiting for Xcode Command Line Tools installation to complete..."
    retries=0
    until xcode-select -p &> /dev/null; do
        sleep 5
        retries=$((retries + 1))
        # Detect if the user cancelled the install dialog
        if ! pgrep -q "Install Command Line Developer Tools" &> /dev/null && [ "$retries" -ge 3 ]; then
            echo "Error: Xcode Command Line Tools installation was cancelled or failed."
            exit 1
        fi
        if [ "$retries" -ge 120 ]; then
            echo "Error: Xcode Command Line Tools installation timed out after 10 minutes."
            exit 1
        fi
    done
    echo "Xcode Command Line Tools installed."
fi

echo "Installing Homebrew packages and casks..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update Homebrew to ensure fresh formulae
brew update

# Shell plugins
brew install \
    starship \
    zsh-autosuggestions \
    zsh-fast-syntax-highlighting

# CLI tools
brew install \
    fzf \
    fd \
    ripgrep \
    bat \
    eza \
    zoxide \
    yazi \
    jq \
    tealdeer

# Editors
brew install \
    vim \
    neovim

# Dev tools
brew install \
    git \
    git-delta \
    uv \
    ruff \
    fnm

# Apps — terminal & editors
brew install --cask \
    font-meslo-lg-nerd-font \
    ghostty \
    visual-studio-code \
    cursor

# Apps — browsers
brew install --cask \
    google-chrome \
    arc

# Apps — utilities
brew install --cask \
    raycast \
    shottr \
    rectangle \
    pearcleaner \
    obsidian \
    spotify

# Container runtime — choose OrbStack (lightweight) or Docker Desktop
echo ""
read -p "Install [o]rbstack or [d]ocker? (o/d): " container_choice
case "$container_choice" in
    o|O) brew install --cask orbstack ;;
    d|D) brew install --cask docker ;;
    *)   echo "  skip: no container runtime selected" ;;
esac

# Populate tealdeer cache so `tldr` works on first use
tldr --update

echo ""
echo "Done. All packages and applications installed."
