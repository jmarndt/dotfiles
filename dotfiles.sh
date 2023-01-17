#!/bin/bash
DOTFILES_DIR=~/dotfiles
SHELLRC=.zshrc
VIMRC=.vimrc
GIT_CONF=.gitconfig

[ -L ~/$SHELLRC ] && rm ~/$SHELLRC
[ -f ~/$SHELLRC ] && rm ~/$SHELLRC
ln -s $DOTFILES_DIR/$SHELLRC ~/$SHELLRC

[ -L ~/$VIMRC ] && rm ~/$VIMRC
[ -f ~/$VIMRC ] && rm ~/$VIMRC
ln -s $DOTFILES_DIR/$VIMRC ~/$VIMRC

[ -L ~/$GIT_CONF ] && rm ~/$GIT_CONF
[ -f ~/$GIT_CONF ] && rm ~/$GIT_CONF
ln -s $DOTFILES_DIR/$GIT_CONF ~/$GIT_CONF
