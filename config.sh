#!/usr/bin/env bash

# config.sh — Configure git and install language runtimes

set -euo pipefail

eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || true

# Git (prompt only if not already set)
echo "Configuring git..."
if [ -z "$(git config --global user.name)" ]; then
    read -p "  Git user name: " git_name
    git config --global user.name "$git_name"
else
    echo "  skip: user.name (already set to '$(git config --global user.name)')"
fi
if [ -z "$(git config --global user.email)" ]; then
    read -p "  Git user email: " git_email
    git config --global user.email "$git_email"
else
    echo "  skip: user.email (already set to '$(git config --global user.email)')"
fi
git config --global core.editor nvim
git config --global init.defaultBranch main
git config --global pull.rebase true
git config --global push.autoSetupRemote true
git config --global rerere.enabled true
git config --global diff.algorithm histogram
git config --global merge.conflictstyle zdiff3
git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.line-numbers true

# Node.js LTS via fnm
if command -v fnm &> /dev/null; then
    echo ""
    echo "Installing Node.js LTS via fnm..."
    eval "$(fnm env)"
    fnm install --lts
    fnm default lts-latest
else
    echo "  skip: fnm not found (run install.sh first)"
fi

# Python via uv
if command -v uv &> /dev/null; then
    echo ""
    echo "Installing latest Python via uv..."
    uv python install
else
    echo "  skip: uv not found (run install.sh first)"
fi

echo ""
echo "Done. Git configured and runtimes installed."
