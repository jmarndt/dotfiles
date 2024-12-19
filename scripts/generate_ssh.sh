#!/bin/bash

SSH_KEY_PATH=~/.ssh/id_ed25519

if [ ! -f $SSH_KEY_PATH ]; then
    ssh-keygen -t ed25519 -N "" -f $SSH_KEY_PATH
fi
