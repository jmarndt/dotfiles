#!/bin/bash

TITLE="CLONING DOTFILES REPOSITORY"
COMMAND="git clone https://github.com/jmarndt/dotfiles.git $DOTFILES"
log_title

git clone https://github.com/jmarndt/dotfiles.git $DOTFILES &>> $INTALL_LOG
