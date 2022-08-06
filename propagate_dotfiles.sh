#!/bin/sh

# Set variables
DOTFILES_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DF_DEST=$HOME/.df

#SHELLRC_SOURCE=$DOTFILES_DIR/zsh/zshrc
#VIMRC_SOURCE=$DOTFILES_DIR/vim/vimrc
#TMUX_SOURCE=$DOTFILES_DIR/tmux/tmux.conf
#GIT_SOURCE=$DOTFILES_DIR/git/gitconfig
#SHELLRC_DEST=$HOME/.zshrc
#VIMRC_DEST=$HOME/.vimrc
#TMUX_DEST=$HOME/.tmux.conf
#$HOME/$GIT_CONF=$HOME/.gitconfig

SHELLRC=.zshrc
VIMRC=.vimrc
TMUX_CONF=.tmux.conf
GIT_CONF=.gitconfig

# Shell RC 
[ -L "$HOME/$SHELLRC" ] && rm $HOME/$SHELLRC
[ -f "$HOME/$SHELLRC" ] && mv $HOME/$SHELLRC $HOME/$SHELLRC.bak.$(date +%m%d%Y-%H%M%S)
ln -s $DOTFILES_DIR/$SHELLRC $HOME/$SHELLRC

# Vim RC
[ -L "$HOME/$VIMRC" ] && rm $HOME/$VIMRC
[ -f "$HOME/$VIMRC" ] && mv $HOME/$VIMRC $HOME/$VIMRC.bak.$(date +%m%d%Y-%H%M%S)
ln -s $DOTFILES_DIR/$VIMRC $HOME/$VIMRC

# Tmux Conf
[ -L "$HOME/$TMUX_CONF" ] && rm $HOME/$TMUX_CONF
[ -f "$HOME/$TMUX_CONF" ] && mv $HOME/$TMUX_CONF $HOME/$TMUX_CONF.bak.$(date +%m%d%Y-%H%M%S)
ln -s $DOTFILES_DIR/$TMUX_CONF $HOME/$TMUX_CONF

# Git Config
[ -L "$HOME/$GIT_CONF" ] && rm $HOME/$GIT_CONF
[ -f "$HOME/$GIT_CONF" ] && mv $HOME/$GIT_CONF $HOME/$GIT_CONF.bak.$(date +%m%d%Y-%H%M%S)
ln -s $DOTFILES_DIR/$GIT_CONF $HOME/$GIT_CONF

# Update dotfiles directory location
echo "export DOTFILES_DIR=\"$DOTFILES_DIR\"" > $DF_DEST
