#!/usr/bin/env bash

# link.sh — Create symlinks for configuration files

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Creating symlinks..."

link() {
    local src="$1"
    local dest="$2"
    local name="$(basename "$dest")"

    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        echo "  WARN: ${name} exists but is not a symlink — skipping (back it up or remove it, then re-run)"
    elif [ -L "$dest" ]; then
        local current_target
        current_target="$(readlink "$dest")"
        if [ "$current_target" = "$src" ]; then
            echo "  skip: ${name} (already linked)"
        else
            echo "  fix:  ${name} (was → ${current_target})"
            rm "$dest"
            ln -s "$src" "$dest"
        fi
    else
        mkdir -p "$(dirname "$dest")"
        ln -s "$src" "$dest"
        echo "  link: ${name}"
    fi
}

# Shell
link "${DIR}/.zshrc"              ~/.zshrc

# Pip
link "${DIR}/pip.conf"            ~/.config/pip/pip.conf

# Starship
link "${DIR}/starship.toml"       ~/.config/starship.toml

# Vim
link "${DIR}/.vimrc"              ~/.vimrc

# Neovim
link "${DIR}/nvim"                ~/.config/nvim

# Ghostty
link "${DIR}/ghostty/config"      ~/.config/ghostty/config

# Local overrides (created empty, not symlinked — lives only on this machine)
if [ ! -f ~/.zshlocal ]; then
    echo "# ~/.zshlocal — Machine-specific config (not committed)" > ~/.zshlocal
    echo "# Add work tokens, secrets, and local overrides here." >> ~/.zshlocal
    echo "  create: .zshlocal"
else
    echo "  skip: .zshlocal (already exists)"
fi

echo "Done."
