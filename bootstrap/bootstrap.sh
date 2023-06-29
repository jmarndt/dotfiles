#!/bin/bash

USAGE="USAGE: bootstrap.sh [ debian | mac ]"
VALID_ARGS=("debian" "mac")

if [ "$#" != "1" ]; then
    echo -e "$USAGE\n"
    exit 1
fi

if echo "${VALID_ARGS[@]}" | grep -qw "$1"; then
    curl https://raw.githubusercontent.com/jmarndt/dotfiles/master/bootstrap/bootstrap_funcs.sh | bash -s $1
else
    echo -e "$USAGE\n"
    exit 2
fi
