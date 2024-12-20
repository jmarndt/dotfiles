#!/bin/bash

DOTFILES=$HOME/dotfiles
INTALL_LOG=$HOME/.dotfiles_install.log
FLAG=$1
BANNER="
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░                                                                  ░░
░░   ██████╗  █████╗ ████████╗███████╗██╗██╗     ███████╗███████╗   ░░
░░   ██╔══██╗██╔══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝   ░░
░░   ██║  ██║██║  ██║   ██║   █████╗  ██║██║     █████╗  ███████╗   ░░
░░   ██║  ██║██║  ██║   ██║   ██╔══╝  ██║██║     ██╔══╝   ╚═══██╗   ░░
░░   ██████╔╝╚█████╔╝   ██║   ██║     ██║███████╗███████╗███████║   ░░
░░   ╚═════╝  ╚════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝   ░░
░░                                                                  ░░
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
"
RESET="\033[0m" DEFAULT="\033[39m" BOLD="\033[1m" RED="\033[91m" GREEN="\033[92m" CLEAR_SCREEN="\33c\e[3J"
DIVIDER="======================================================================"

log_title() {
    echo -e "\n$DIVIDER\n$TITLE" 2>&1 | tee -a $INTALL_LOG
    echo -e "Command: $COMMAND\n\nOUTPUT:\n-------\n" &>> $INTALL_LOG
}

printf $CLEAR_SCREEN
echo -e "$GREEN$BANNER$RESET" && echo -e "$BANNER" > $DOTFILES/install.log
echo -e "$BOLD""Detailed installation logs: '$INTALL_LOG'$RESET"
[ -f /etc/os-release ] && source /etc/os-release

if [ ! -d $DOTFILES ]; then
    TITLE="CLONING DOTFILES REPOSITORY"
    COMMAND="git clone https://github.com/jmarndt/dotfiles.git $DOTFILES"
    log_title

    git clone https://github.com/jmarndt/dotfiles.git $DOTFILES &>> $INTALL_LOG
fi
if [[ $PRETTY_NAME = *Debian* || $PRETTY_NAME = *Ubuntu* ]]; then
    source $DOTFILES/scripts/apt.sh
    source $DOTFILES/scripts/flatpak.sh
fi
if [[ $PRETTY_NAME = *Fedora* ]]; then
    source $DOTFILES/scripts/dnf.sh
    source $DOTFILES/scripts/flatpak.sh
fi
if [[ $OSTYPE = 'darwin'* ]]; then
    source $DOTFILES/scripts/macos.sh
    source $DOTFILES/scripts/homebrew.sh
fi

source $DOTFILES/scripts/ssh.sh
source $DOTFILES/scripts/git.sh
source $DOTFILES/scripts/node.sh
source $DOTFILES/scripts/link.sh

echo -e "$BOLD\nComplete, dotfiles are now installed!\n$RESET"
