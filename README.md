# dotfiles

My macOS setup — automated with a single command.

```bash
git clone <repo-url> ~/dotfiles && cd ~/dotfiles && ./setup.sh
```

This runs four steps in order: installs packages (`install.sh`), creates symlinks (`link.sh`), configures git and runtimes (`config.sh`), and applies macOS settings (`macos.sh`). You can also run each step individually:

```bash
./setup.sh install   # Install Homebrew packages and apps
./setup.sh link      # Create symlinks for config files
./setup.sh config    # Configure git and install runtimes
./setup.sh macos     # Apply macOS system preferences
```

The install step asks two questions up-front (arrow keys + Enter to pick) and then shows a summary of what will be installed before running anything:

- **Environment** — `personal` or `work`. Personal adds a few extra apps (e.g. KeePassXC, Google Drive).
- **Container runtime** — `orbstack`, `docker`, or `none`.

---

## Repository structure

```
~/dotfiles/
├── setup.sh          # Orchestrator — runs everything
├── install.sh        # Homebrew packages and casks
├── link.sh           # Symlinks for config files
├── config.sh         # Git config and language runtimes
├── macos.sh          # macOS system preferences (defaults write)
├── .zshrc            # Shell configuration
├── starship.toml     # Prompt configuration
├── ghostty/config    # Terminal configuration
├── .vimrc            # Vim configuration
├── nvim/init.lua     # Neovim configuration
├── pip.conf          # Pip configuration
├── .gitignore
└── legacy/           # Previous configs (tmux, vim, alacritty, karabiner)
```

---

## What gets installed

### Terminal tools

| Tool | Replaces | Purpose |
|------|----------|---------|
| [Starship](https://starship.rs/) | Powerlevel10k | Cross-shell prompt, Rust-based, actively maintained |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Oh My Zsh plugin | Ghost text suggestions from history |
| [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) | Oh My Zsh plugin | Commands turn green/red as you type (faster than zsh-syntax-highlighting) |
| [fzf](https://github.com/junegunn/fzf) | — | Fuzzy finder (unchanged, still the best) |
| [fd](https://github.com/sharkdp/fd) | find | Fast file search, respects .gitignore |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | grep | Fast content search, respects .gitignore |
| [bat](https://github.com/sharkdp/bat) | cat | Syntax highlighting, line numbers, git diff |
| [eza](https://github.com/eza-community/eza) | ls | Colors, icons, git status, tree view |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | cd | Smarter directory jumping, learns your habits |
| [delta](https://github.com/dandavison/delta) | diff | Syntax-highlighted git diffs with line numbers |
| [tealdeer](https://github.com/dbrgn/tealdeer) | man | Community-driven simplified command examples (tldr) |
| [yazi](https://github.com/sxyazi/yazi) | Ranger + vifm | Terminal file manager, Rust-based, async, image preview |
| [jq](https://github.com/jqlang/jq) | — | JSON processor |
| [git](https://git-scm.com/) | Xcode CLT git | Latest version via Brew, updated more frequently |
| [vim](https://www.vim.org/) | macOS built-in vim | Latest version via Brew |
| [Neovim](https://neovim.io/) | — | Modern vim fork, LSP/treesitter ready |
| [uv](https://github.com/astral-sh/uv) | pip, virtualenv, pyenv | Python package/project manager, Rust-based, handles Python versions too |
| [Ruff](https://github.com/astral-sh/ruff) | flake8, black, isort | Python linter and formatter, Rust-based |
| [fnm](https://github.com/Schniz/fnm) | nvm | Fast Node version manager, Rust-based, near-zero shell startup cost |

### Applications

| App | Replaces | Purpose |
|-----|----------|---------|
| [Ghostty](https://ghostty.org/) | Alacritty | Terminal emulator, native Metal rendering |
| [VS Code](https://code.visualstudio.com/) | — | Code editor (unchanged) |
| [Cursor](https://www.cursor.com/) | — | AI-native code editor (VS Code fork) |
| [Chrome](https://www.google.com/chrome/) | — | Browser (unchanged) |
| [Arc](https://arc.net/) | — | Browser with spaces, split views, built-in tools |
| [Raycast](https://www.raycast.com/) | Spotlight | Launcher, clipboard history, snippets, plugins |
| [Shottr](https://shottr.cc/) | Monosnap | Screenshots, OCR, annotations |
| [Spotify](https://www.spotify.com/) | — | Music (unchanged) |
| [Pearcleaner](https://github.com/alienator88/Pearcleaner) | Pretty Clean | Clean app uninstaller |
| [Rectangle](https://rectangleapp.com/) | — | Window manager with keyboard shortcuts |
| [Obsidian](https://obsidian.md/) | — | Markdown-based knowledge base |
| [Postman](https://www.postman.com/) | — | API client for testing HTTP requests |
| [KeePassXC](https://keepassxc.org/) | — | Password manager (personal only) |
| [Google Drive](https://www.google.com/drive/) | — | Cloud file sync (personal only) |
| [OrbStack](https://orbstack.dev/) or [Docker Desktop](https://www.docker.com/products/docker-desktop/) | — | Container runtime (picked during install — or skip) |

### Chrome extensions

- [Vimium](https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb) — keyboard-driven browsing
- [uBlock Origin](https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm) — ad blocker
- [JSON Viewer Pro](https://chrome.google.com/webstore/detail/json-viewer-pro/eifflpmocdbdmepbjaopkkhbfmdgijcc) — JSON formatting and tree view

---

## What gets configured

**Dev runtimes** — Installs latest LTS Node.js (via fnm) and latest stable Python (via uv) so you have working `node`/`npm`/`npx` and `python` out of the box. Add more versions anytime with `fnm install 22` or `uv python install 3.11`.

**Git** — Prompts for `user.name` and `user.email` if not already configured. Sets `init.defaultBranch` to `main`. Configures delta as pager with line numbers and navigation.

**Shell (.zshrc)** — Bare zsh with no framework, vi keybindings. Includes: cached completions via `compinit`, autosuggestions, fast syntax highlighting, Starship prompt, fzf integration with fd, zoxide (`q` command) for smart directory jumping, git aliases, eza/bat aliases, `sshid` helper function, and Ctrl+E to edit the current command line in `$EDITOR`. Machine-specific secrets go in `~/.zshlocal` (not committed).

**Prompt (starship.toml)** — Based on Starship defaults with full path display (no truncation).

**Terminal (ghostty/config)** — Ghostty with MesloLGS Nerd Font at 14pt, Option-as-Alt for fzf keybindings, and Ctrl+H/J/K/L for vim-like split navigation.

**macOS (macos.sh)** — System preferences automated via `defaults write`. Covers: Finder (show hidden files, path bar, list view), Dock (auto-hide, no recents, small icons), keyboard (fast repeat, F-keys as standard, fn → do nothing), trackpad (tap to click, 3-finger drag, two-finger swipe for browser back/forward), screenshots (PNG to ~/Pictures), hot corners disabled, menu bar (Sound icon, battery percentage), and more. See the file for the complete list.

---

## Manual steps (not automatable)

After running `setup.sh`, configure these through System Settings:

- **Keyboard → Modifier Keys:** Make Caps Lock act as Ctrl
- **Keyboard → Keyboard Shortcuts → Input Sources:** Set `Cmd+Space` to switch input source (language)
- **Keyboard → Keyboard Shortcuts → Mission Control:** Disable `Ctrl+Up`, `Ctrl+Down`, `Ctrl+Left`, `Ctrl+Right` — they interfere with terminal shortcuts
- **Raycast preferences:** Confirm `Opt+Space` as hotkey (should be set by default on first launch)
- **Displays → Night Shift:** Set to "Sunset to Sunrise"

---

## Consider later

**Terminal multiplexer:** If Ghostty's built-in splits aren't enough, [tmux](https://github.com/tmux/tmux) is proven (old config in `legacy/.tmux.conf`). [Zellij](https://zellij.dev/) is the modern Rust-based alternative with sane defaults.

**Neovim config:** Consider a distribution like [LazyVim](https://www.lazyvim.org/) or [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) for a full IDE experience with LSP and treesitter. Old `.vimrc` is in `legacy/`.

**Caps Lock → Ctrl/Escape:** If you want Caps Lock to act as Ctrl when held and Escape when tapped (not just Ctrl), you'll need [Karabiner-Elements](https://karabiner-elements.pqrs.org/) back. Old config in `legacy/karabiner/`.
