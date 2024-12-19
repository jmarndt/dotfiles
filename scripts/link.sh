#!/bin/bash

link_dotfile() {
    dotfile=$1
    [ -L $HOME/.$dotfile ] && rm $HOME/.$dotfile
    [ -f $HOME/.$dotfile ] && rm $HOME/.$dotfile
    ln -s $HOME/dotfiles/configs/$dotfile $HOME/.$dotfile
}

link_shellrc() {
    SHELLRC=""
    SOURCE="source $HOME/dotfiles/configs/shellrc"
    [[ $SHELL = "/bin/zsh" ]] && SHELLRC=zshrc
    [[ $SHELL = "/bin/bash" ]] && SHELLRC=bashrc
    [ -f $HOME/.$SHELLRC ] && grep -v "$SOURCE" $HOME/.$SHELLRC > temp && mv temp $HOME/.$SHELLRC
    echo $SOURCE >> $HOME/.$SHELLRC
}

TITLE="LINKING DOTFILES"
COMMAND="N/A"
log_title

link_dotfile "vimrc"
link_dotfile "sqliterc"
link_dotfile "gitconfig"
link_dotfile "stignore"
link_dotfile "tmux.conf"
link_shellrc
