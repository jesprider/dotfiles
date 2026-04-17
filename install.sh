#!/usr/bin/env bash

# install.sh — Install packages and applications via Homebrew

set -euo pipefail

# choose "Prompt?" option1 option2 ... — interactive single-select picker.
# Navigate with ↑/↓, confirm with Enter. Prints selected option to stdout.
choose() {
    local prompt="$1"; shift
    local options=("$@")
    local selected=0 key esc i

    tput civis >&2
    trap 'tput cnorm >&2' EXIT

    echo "$prompt" >&2
    while true; do
        for i in "${!options[@]}"; do
            tput el >&2
            if [[ $i -eq $selected ]]; then
                echo "❯ ${options[$i]}" >&2
            else
                echo "  ${options[$i]}" >&2
            fi
        done

        IFS= read -rsn1 key
        if [[ $key == $'\x1b' ]]; then
            # Arrow keys send ESC [ A/B — bytes are already buffered, so a
            # blocking 2-char read returns immediately. Avoid `-t <fraction>`:
            # macOS ships bash 3.2, which rejects fractional timeouts.
            read -rsn2 esc
            if [[ $esc == '[A' && $selected -gt 0 ]]; then
                selected=$((selected - 1))
            elif [[ $esc == '[B' && $selected -lt $((${#options[@]} - 1)) ]]; then
                selected=$((selected + 1))
            fi
        elif [[ -z $key ]]; then
            break
        fi
        tput cuu "${#options[@]}" >&2
    done

    tput cnorm >&2
    echo "${options[$selected]}"
}

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

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Gather setup answers up-front so the rest runs unattended
echo ""
echo "=== Setup questions ==="
ENV_TYPE=$(choose "Environment?" personal work)
CONTAINER_RUNTIME=$(choose "Container runtime?" orbstack docker none)

# Show what will be installed based on the answers
echo ""
echo "=== Will install ==="
echo "  shell:     starship, zsh-autosuggestions, zsh-fast-syntax-highlighting"
echo "  cli:       fzf, fd, ripgrep, bat, eza, zoxide, yazi, jq, tealdeer"
echo "  editors:   vim, neovim, visual-studio-code, cursor"
echo "  dev:       git, git-delta, uv, ruff, fnm"
echo "  terminal:  ghostty, font-meslo-lg-nerd-font"
echo "  browsers:  google-chrome, arc"
echo "  utils:     raycast, shottr, rectangle, pearcleaner, obsidian"
echo "  media:     spotify"
if [[ "$ENV_TYPE" == "personal" ]]; then
    echo "  personal:  keepassxc"
fi
case "$CONTAINER_RUNTIME" in
    orbstack|docker) echo "  container: $CONTAINER_RUNTIME" ;;
esac
echo ""

if [[ $(choose "Looks good?" yes no) == "no" ]]; then
    echo "Aborted."
    exit 0
fi
echo ""

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
brew install --cask \
    visual-studio-code \
    cursor

# Dev tools
brew install \
    git \
    git-delta \
    uv \
    ruff \
    fnm

# Apps — terminal
brew install --cask \
    font-meslo-lg-nerd-font \
    ghostty

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
    obsidian

# Apps — media
brew install --cask spotify

# Apps — personal only
if [[ "$ENV_TYPE" == "personal" ]]; then
    brew install --cask keepassxc
fi

# Container runtime
case "$CONTAINER_RUNTIME" in
    orbstack) brew install --cask orbstack ;;
    docker)   brew install --cask docker ;;
    none)     echo "  skip: no container runtime selected" ;;
esac

# Populate tealdeer cache so `tldr` works on first use
tldr --update

echo ""
echo "Done. All packages and applications installed."
