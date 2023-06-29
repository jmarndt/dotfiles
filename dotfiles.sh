#!/bin/bash

DOTFILES_DIR=$HOME/dotfiles
SOURCE="source $DOTFILES_DIR/shellrc"
SHELLRC=""

link_dotfile() {
    dotfile=$1
    [ -L $HOME/.$dotfile ] && rm $HOME/.$dotfile
    [ -f $HOME/.$dotfile ] && rm $HOME/.$dotfile
    ln -s $DOTFILES_DIR/$dotfile $HOME/.$dotfile
}

link_shellrc() {
    [[ $SHELL = "/bin/zsh" ]] && SHELLRC=zshrc
    [[ $SHELL = "/bin/bash" ]] && SHELLRC=bashrc
    [ -f $HOME/.$SHELLRC ] && grep -v "$SOURCE" $HOME/.$SHELLRC > temp && mv temp $HOME/.$SHELLRC
    echo $SOURCE >> $HOME/.$SHELLRC
}

main() {
    link_dotfile "vimrc"
    link_dotfile "sqliterc"
    link_dotfile "gitconfig"
    link_shellrc
}

main
