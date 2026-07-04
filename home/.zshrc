#!/usr/bin/env zsh

# Initialize Starship prompt
eval "$(starship init zsh)"

# Initialize zoxide (z command)
eval "$(zoxide init zsh)"

# History configuration
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

# Completion
autoload -Uz compinit
compinit

# Source syntax highlighting and autosuggestions (from Homebrew)
if [[ -f /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [[ -f /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Homebrew PATH
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# direnv hook
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

# uv initialization
if command -v uv &> /dev/null; then
  eval "$(uv generate-shell-completion zsh 2>/dev/null || true)"
fi

# fzf integration (if installed)
if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
fi

# Aliases
alias ls='eza'
alias la='eza -la'
alias ll='eza -l'
alias tree='eza --tree'
alias cat='bat'
alias grep='grep --color=auto'
alias cd='z'

# SOPS editor
export SOPS_EDITOR=/usr/bin/nano

# Local env file if exists
if [[ -f ~/.local/bin/env ]]; then
  . ~/.local/bin/env
fi

# OpenCode path if exists
if [[ -d ~/.opencode/bin ]]; then
  export PATH=$HOME/.opencode/bin:$PATH
fi
