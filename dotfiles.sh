#!/bin/bash

DOTFILES_DIR=$HOME/dotfiles

link_dotfile() {
    dotfile=$1
    [ -L $HOME/.$dotfile ] && rm $HOME/.$dotfile
    [ -f $HOME/.$dotfile ] && rm $HOME/.$dotfile
    ln -s $DOTFILES_DIR/$dotfile $HOME/.$dotfile
}

link_shellrc() {
    SOURCE="source $DOTFILES_DIR/shellrc"

    if [[ $SHELL = "/bin/zsh" ]]; then
        ZSHRC=zshrc

        [ -f $HOME/.$ZSHRC ] && grep -v "$SOURCE" $HOME/.$ZSHRC > temp && mv temp $HOME/.$ZSHRC
        echo $SOURCE >> $HOME/.$ZSHRC
    fi
    if [[ $SHELL = "/bin/bash" ]]; then
        BASHRC=bashrc

        [ -f $HOME/.$BASHRC ] && grep -v "$SOURCE" $HOME/.$BASHRC > temp && mv temp $HOME/.$BASHRC
        echo $SOURCE >> $HOME/.$BASHRC
    fi
}

main() {
    link_dotfile "vimrc"
    link_dotfile "sqliterc"
    link_dotfile "gitconfig"

    link_shellrc
}

main
