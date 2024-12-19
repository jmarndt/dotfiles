#!/bin/bash

REPO="https://raw.githubusercontent.com/jmarndt/dotfiles/master"
RESET="\033[0m" DEFAULT="\033[39m" BOLD="\033[1m" RED="\033[91m" GREEN="\033[92m"

echo -e "$GREEN
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░                          INSTALLING                              ░░
░░                                                                  ░░
░░   ██████╗  █████╗ ████████╗███████╗██╗██╗     ███████╗███████╗   ░░
░░   ██╔══██╗██╔══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝   ░░
░░   ██║  ██║██║  ██║   ██║   █████╗  ██║██║     █████╗  ███████╗   ░░
░░   ██║  ██║██║  ██║   ██║   ██╔══╝  ██║██║     ██╔══╝   ╚═══██╗   ░░
░░   ██████╔╝╚█████╔╝   ██║   ██║     ██║███████╗███████╗███████║   ░░
░░   ╚═════╝  ╚════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝   ░░
░░                                                                  ░░
░░                                                                  ░░
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
$RESET"

if [ ! -d $HOME/dotfiles ]; then
    git clone https://github.com/jmarndt/dotfiles.git $HOME/dotfiles
fi


[ -f /etc/os-release ] && source /etc/os-release
if [[ $PRETTY_NAME = *Debian* ]]; then
    source $HOME/dotfiles/scripts/install_debian.sh
fi
if [[ $PRETTY_NAME = *Fedora* ]]; then
    source $HOME/dotfiles/scripts/install_fedora.sh
fi
if [[ $OSTYPE = 'darwin'* ]]; then
    source $HOME/dotfiles/scripts/install_macos.sh
fi
