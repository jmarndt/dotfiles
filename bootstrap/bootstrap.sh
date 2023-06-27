#!/bin/bash

USAGE="USAGE: bootstrap.sh [ fedora | mac ]"
VALID_ARGS=("fedora" "mac")

if [ "$#" != "1" ]; then
    echo -e "$USAGE\n"
    exit 1
fi

if echo "${VALID_ARGS[@]}" | grep -qw "$1"; then
    curl https://raw.githubusercontent.com/jmarndt/dotfiles/master/bootstrap/bootstrap_funcs.sh --output ./bootstrap_temp.sh
    ./bootstrap_temp.sh $1
    rm ./bootstrap_temp.sh
else
    echo -e "$USAGE\n"
    exit 1
fi