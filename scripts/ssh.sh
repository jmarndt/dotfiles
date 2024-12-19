#!/bin/bash

SSH_KEY_PATH=~/.ssh/id_ed25519

if [ ! -f $SSH_KEY_PATH ]; then
    TITLE="GENERATING SSH KEYS"
    COMMAND="ssh-keygen -t ed25519 -N "" -f $SSH_KEY_PATH"
    log_title

    ssh-keygen -t ed25519 -N "" -f $SSH_KEY_PATH &>> $INTALL_LOG
fi
