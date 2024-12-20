#!/bin/bash

DOTFILES=$HOME/dotfiles
INTALL_LOG=$DOTFILES/install.log
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
source $DOTFILES/scripts/init.sh

if [ ! -d $DOTFILES ]; then
    source $DOTFILES/scripts/clone.sh
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
