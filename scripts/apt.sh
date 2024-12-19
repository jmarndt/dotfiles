#!/bin/bash

TITLE="INSTALLING APT PACKAGES"
COMMAND="sudo apt install -y $(cat $DOTFILES/packages/linux)"
log_title

[[ $XDG_CURRENT_DESKTOP = "GNOME" ]] && sudo apt install -y gnome-software-plugin-flatpak &>> $INTALL_LOG
sudo apt install -y $(cat $DOTFILES/packages/linux) &>> $INTALL_LOG
