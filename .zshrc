# ~/.zshrc

# ---- Environment ----
export VISUAL=nvim
export EDITOR="$VISUAL"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Don't exit shell on Ctrl-D
set -o ignoreeof

# Use vim bindings
bindkey -v

# ---- History ----
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS   # remove older duplicate when new one is added
setopt HIST_IGNORE_SPACE      # don't store commands starting with a space
setopt HIST_REDUCE_BLANKS     # remove extra blanks from commands
setopt SHARE_HISTORY          # share history across all sessions (implies INC_APPEND_HISTORY)

# ---- Completions (cached, rebuilds once per day) ----
autoload -Uz compinit
if [[ ! -f ~/.zcompdump ]] || [[ -n $(find ~/.zcompdump -mtime +0 2>/dev/null) ]]; then
    compinit -d ~/.zcompdump
else
    compinit -C -d ~/.zcompdump
fi

# ---- Plugins ----
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# ---- fnm (Node version manager) ----
eval "$(fnm env --use-on-cd)"

# ---- zoxide (smarter cd) ----
eval "$(zoxide init zsh --cmd q)"

# ---- fzf ----
source <(fzf --zsh)
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# ---- Aliases ----
alias g='git'
alias gst='git status'
alias gco='git checkout'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias ga='git add'
alias gcm='git commit -m'
alias glog='git log --oneline --graph --decorate'

alias ls='eza'
alias ll='eza -l --git'
alias la='eza -la --git'
alias tree='eza --tree'

alias cat='bat --paging=never --plain'

# ---- Functions ----

# Enter an ssh passphrase for 6 hours
sshid() {
    local key="${1:-$HOME/.ssh/id_ed25519}"
    [[ -f "$key" ]] || { echo "Key not found: $key"; return 1; }
    ssh-add -l | grep -q "$(ssh-keygen -lf "$key" | awk '{print $2}')" \
        || ssh-add -t 21600 "$key"
}

# ---- Edit command line in $EDITOR (Ctrl+E) ----
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# ---- Local overrides (secrets, work tokens — not committed) ----
[ -f ~/.zshlocal ] && source ~/.zshlocal

# ---- Prompt ----
eval "$(starship init zsh)"