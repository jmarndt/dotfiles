#!/bin/bash
USAGE="USAGE: ./bootstrap [ deb | mac ]"
VALID_ARGS=("deb" "mac")
BOOTSTRAP_FUNCS_FILE="bootstrap_funcs.sh"
BOOTSTRAP_FUNCS_URL="https://raw.githubusercontent.com/jmarndt/dotfiles/master/bootstrap/$BOOTSTRAP_FUNCS_FILE"

if [ "$#" != "1" ]; then
    echo -e "$USAGE\n"
    exit 1
fi

if echo "${VALID_ARGS[@]}" | grep -qw "$1"; then
    # curl $BOOTSTRAP_FUNCS_URL --output ./$BOOTSTRAP_FUNCS_FILE
    source $BOOTSTRAP_FUNCS_FILE
    bootstrap $1
    # rm ./$BOOTSTRAP_FUNCS_FILE
else
    echo -e "$USAGE\n"
    exit 1
fi