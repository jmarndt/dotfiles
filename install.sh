#!/bin/bash

DOTFILES=$HOME/dotfiles

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

[ -f /etc/os-release ] && source /etc/os-release

if [ ! -d $DOTFILES ]; then
    git clone https://github.com/jmarndt/dotfiles.git $DOTFILES
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
