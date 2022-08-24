################################################################################
# System 
################################################################################
source $HOME/.df
export LESSHISTFILE=$HOME/.lesshst
export HISTFILE=$HOME/.zsh_history
export PATH="$PATH:$HOME/.dotnet/tools"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

bindkey -v
autoload -U colors && colors
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
setopt nobeep autocd


################################################################################
# Prompt 
################################################################################
autoload -U promptinit
autoload -Uz vcs_info
setopt prompt_subst

precmd() { vcs_info }
zstyle ':vcs_info:*' formats '%{%F{green}%}%u%c%B(%b)%{%f%}'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%{%f%}%{%F{red}%}'
zstyle ':vcs_info:*' unstagedstr '%{%f%}%{%F{red}%}'

#PROMPT='%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b '
PROMPT='%B'
PROMPT+='%{$fg[red]%}['
PROMPT+='%{$fg[yellow]%}%n'
PROMPT+='%{$fg[green]%}@'
PROMPT+='%{$fg[blue]%}%M '
PROMPT+='%{$fg[magenta]%}%~'
PROMPT+='%{$fg[red]%}]'
PROMPT+='%{$reset_color%}$%b '
RPROMPT='${vcs_info_msg_0_}'


################################################################################
# Custom functions
################################################################################
mkbak() {
  filename=$1
  cp $filename ${filename}.bak.$(date +%m%d%Y-%H%M%S)
}

rsbak() {
  filename=$1
  mv $filename ${filename%%.bak*}
}

take() {
  mkdir -p $1 && cd $1
}

ggu() {
  [[ "$#" != 1 ]] && local b=$(git_current_branch)
	git pull --rebase origin "${b:=$1}"
}

git_current_branch() {
  git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/\1/p'
}

git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return
    fi
  done
  echo master
}


################################################################################
# Aliases 
################################################################################
alias v="vim"
alias vimrc="vim ~/.vimrc"
alias src="source ~/.zshrc"
alias edt="vim ~/.zshrc"
alias .df="cd $DOTFILES_DIR"
alias clr="clear"
alias sys="systemctl"
alias cp="cp -iv"
alias mv="mv -iv"
alias l='ls'
alias ls='ls -lah --color'
alias mkdir='mkdir -p'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit -v'
alias 'gc!'='git commit -v --amend'
alias gcm='git checkout $(git_main_branch)'
alias gco='git checkout'
alias glog='git log --oneline --decorate --graph'
alias glol='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'
alias gpf='git push --force-with-lease'
alias grbi='git rebase -i'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'
alias grbm='git rebase $(git_main_branch)'
alias gpu='git push -u origin HEAD'
alias gst='git status'
alias gsts='echo $(git stash show --name-status)'
alias ip="echo $(curl -s https://api.ipify.org)"
