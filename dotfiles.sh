#!/bin/bash
DOTFILES_DIR=$HOME/dotfiles
VIMRC=vimrc
GIT_CONF=gitconfig
ZSHRC=zshrc
SOURCE="source $DOTFILES_DIR/$ZSHRC"

[ -L $HOME/.$VIMRC ] && rm $HOME/.$VIMRC
[ -f $HOME/.$VIMRC ] && rm $HOME/.$VIMRC
ln -s $DOTFILES_DIR/$VIMRC $HOME/.$VIMRC

[ -L $HOME/.$GIT_CONF ] && rm $HOME/.$GIT_CONF
[ -f $HOME/.$GIT_CONF ] && rm $HOME/.$GIT_CONF
ln -s $DOTFILES_DIR/$GIT_CONF $HOME/.$GIT_CONF

[ -f $HOME/$ZSHRC ] && grep -v "$SOURCE" $HOME/.$ZSHRC > temp && mv temp $HOME/.$ZSHRC
echo $SOURCE >> $HOME/.$ZSHRC