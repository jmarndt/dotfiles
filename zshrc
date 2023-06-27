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

PROMPT='%B'
PROMPT+='%{$fg[red]%}['
PROMPT+='%{$fg[yellow]%}%n'
PROMPT+='%{$fg[green]%}@'
PROMPT+='%{$fg[blue]%}%M '
PROMPT+='%{$fg[magenta]%}%~'
PROMPT+='%{$fg[red]%}]'
PROMPT+='%{$reset_color%}$%b '
RPROMPT='${vcs_info_msg_0_}'