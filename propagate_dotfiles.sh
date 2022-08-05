#!/bin/sh

# Set variables
DOTFILES_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DF_DEST=$HOME/.df
SHELLRC_SOURCE=$DOTFILES_DIR/zsh/zshrc
SHELLRC_DEST=$HOME/.zshrc
VIMRC_SOURCE=$DOTFILES_DIR/vim/vimrc
VIMRC_DEST=$HOME/.vimrc
TMUX_SOURCE=$DOTFILES_DIR/tmux/tmux.conf
TMUX_DEST=$HOME/.tmux.conf
GIT_SOURCE=$DOTFILES_DIR/git/gitconfig
GIT_DEST=$HOME/.gitconfig

# Shell RC 
[ -L "$SHELLRC_DEST" ] && rm $SHELLRC_DEST
[ -f "$SHELLRC_DEST" ] && mv $SHELLRC_DEST $SHELLRC_DEST.bak.$(date +%m%d%Y-%H%M%S)
ln -s $SHELLRC_SOURCE $SHELLRC_DEST

# Vim RC
[ -L "$VIMRC_DEST" ] && rm $VIMRC_DEST
[ -f "$VIMRC_DEST" ] && mv $VIMRC_DEST $VIMRC_DEST.bak.$(date +%m%d%Y-%H%M%S)
ln -s $VIMRC_SOURCE $VIMRC_DEST

# Tmux Conf
[ -L "$TMUX_DEST" ] && rm $TMUX_DEST
[ -f "$TMUX_DEST" ] && mv $TMUX_DEST $TMUX_DEST.bak.$(date +%m%d%Y-%H%M%S)
ln -s $TMUX_SOURCE $TMUX_DEST

# Git Config
[ -L "$GIT_DEST" ] && rm $GIT_DEST
[ -f "$GIT_DEST" ] && mv $GIT_DEST $GIT_DEST.bak.$(date +%m%d%Y-%H%M%S)
ln -s $GIT_SOURCE $GIT_DEST

# Update dotfiles location
echo "export DOTFILES_DIR=\"$DOTFILES_DIR\"" > $DF_DEST

# Finish
echo "dotfiles installed! don't forget to source your rc files!"
