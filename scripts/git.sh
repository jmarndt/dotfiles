#!/bin/bash

GIT_DIR=$HOME/git

if [ ! -d $GIT_DIR ]; then
    TITLE="SETTING UP GIT FOLDER"
    COMMAND="mkdir $GIT_DIR && printf \"[user]\n  email = replace@me.com\n\" > $GIT_DIR/.gitconfig"
    log_title

    mkdir $GIT_DIR && printf "[user]\n  email = replace@me.com\n" > $GIT_DIR/.gitconfig &>> $INTALL_LOG
fi
