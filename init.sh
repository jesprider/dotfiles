#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Link vimrc configuration
[ ! -f ~/.vimrc ] && { ln -s "${DIR}/.vimrc" ~; echo ".vimrc symlink created"; } || echo ".vimrc already exists"

# Link tmux configuration
[ ! -f ~/.tmux.conf ] && { ln -s "${DIR}/.tmux.conf" ~; echo ".tmux.conf symlink created"; } || echo ".tmux.conf already exists"

# Link shell configuration
if [ ! -f ~/.zshlocal ]; then
    ln -s "${DIR}/.zshlocal" ~
    echo "source ~/.zshlocal" >> ~/.zshrc
    echo ".zshlocal symlink created"
else
    echo ".zshlocal already exists"
fi

# Link pip configuration
if [ ! -f ~/.config/pip/pip.conf ]; then
    mkdir -p ~/.config/pip
    ln -s "${DIR}/pip.conf" ~/.config/pip
    echo "pip.config symlink created"
else
    echo "pip.conf already exists"
fi

# Link alacritty configuration
if [ ! -f ~/.config/alacritty/alacritty.yml ]; then
    mkdir -p ~/.config/alacritty
    ln -s "${DIR}/alacritty.yml" ~/.config/alacritty
    echo "alacritty.yml symlink created"
else
    echo "alacritty.yml already exists"
fi

# Link karabiner configuration
if [ ! -f ~/.config/karabiner/karabiner.json ]; then
    ln -s "${DIR}/karabiner" ~/.config
    echo "karabiner symlink created"
else
    echo "karabiner already exists"
fi
