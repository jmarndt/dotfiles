#!/bin/bash

WORK_DIR_PATH=$HOME/git

if [ ! -d $WORK_DIR_PATH ]; then
    mkdir $WORK_DIR_PATH
    printf "[user]\n  email = replace@me.com\n" > $WORK_DIR_PATH/.gitconfig
fi
