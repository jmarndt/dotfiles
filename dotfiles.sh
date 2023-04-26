#!/bin/bash
DOTFILES_DIR=$HOME/dotfiles
VIMRC=vimrc
SQLITERC=sqliterc
GIT_CONF=gitconfig
ZSHRC=zshrc
SOURCE="source $DOTFILES_DIR/$ZSHRC"

link_dotfile() {
    dotfile=$1
    [ -L $HOME/.$dotfile ] && rm $HOME/.$dotfile
    [ -f $HOME/.$dotfile ] && rm $HOME/.$dotfile
    ln -s $DOTFILES_DIR/$dotfile $HOME/.$dotfile
}

link_dotfile $VIMRC
link_dotfile $SQLITERC
link_dotfile $GIT_CONF

[ -f $HOME/$ZSHRC ] && grep -v "$SOURCE" $HOME/.$ZSHRC > temp && mv temp $HOME/.$ZSHRC
echo $SOURCE >> $HOME/.$ZSHRC