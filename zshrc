export DOTFILES_DIR=$HOME/dotfiles
export LESSHISTFILE=$HOME/.lesshst
export HISTFILE=$HOME/.zsh_history
export PATH="/usr/local/opt/dotnet@6/bin:/usr/local/sbin:$PATH"

bindkey -v
autoload -U colors && colors
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
setopt nobeep autocd

autoload -U promptinit
autoload -Uz vcs_info
setopt prompt_subst

precmd() { vcs_info }
zstyle ':vcs_info:*' formats '%{%F{green}%}%u%c%B(%b)%{%f%}'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%{%f%}%{%F{red}%}'
zstyle ':vcs_info:*' unstagedstr '%{%f%}%{%F{red}%}'

source $DOTFILES_DIR/prompt
source $DOTFILES_DIR/funcs
source $DOTFILES_DIR/aliases
