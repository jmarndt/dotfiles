#!/bin/bash

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

if [ ! -d $HOME/dotfiles ]; then
    git clone https://github.com/jmarndt/dotfiles.git $HOME/dotfiles
fi
if [[ $PRETTY_NAME = *Debian* || $PRETTY_NAME = *Ubuntu* ]]; then
    source $HOME/dotfiles/scripts/apt.sh
    source $HOME/dotfiles/scripts/flatpak.sh
fi
if [[ $PRETTY_NAME = *Fedora* ]]; then
    source $HOME/dotfiles/scripts/dnf.sh
    source $HOME/dotfiles/scripts/flatpak.sh
fi
if [[ $OSTYPE = 'darwin'* ]]; then
    source $HOME/dotfiles/scripts/macos.sh
    source $HOME/dotfiles/scripts/homebrew.sh
fi

source $HOME/dotfiles/scripts/ssh.sh
source $HOME/dotfiles/scripts/git.sh
source $HOME/dotfiles/scripts/node.sh
source $HOME/dotfiles/scripts/link.sh
