#!/bin/bash

RESET="\033[0m"
DEFAULT="\033[39m"
BOLD="\033[1m"
RED="\033[91m"
GREEN="\033[92m"
CLEAR_SCREEN="\33c\e[3J"
DIVIDER="======================================================================"

log_title() {
    echo -e "\n$DIVIDER\n$TITLE" 2>&1 | tee -a $INTALL_LOG
    echo -e "Command: $COMMAND\n\nOUTPUT:\n-------\n" &>> $INTALL_LOG
}

printf $CLEAR_SCREEN
echo -e "$GREEN$BANNER$RESET" && echo -e "$BANNER" > $DOTFILES/install.log
echo -e "$BOLD""Detailed installation logs: '$INTALL_LOG'$RESET"
[ -f /etc/os-release ] && source /etc/os-release
