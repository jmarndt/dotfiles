#!/bin/bash

TITLE="INSTALLING DNF PACKAGES"
COMMAND="sudo dnf install --skip-unavailable -y $(cat $DOTFILES/packages/linux)"
log_title

[[ $XDG_CURRENT_DESKTOP = "GNOME" ]] && sudo dnf install --skip-unavailable -y gnome-software-plugin-flatpak &>> $INTALL_LOG
sudo dnf install --skip-unavailable -y $(cat $DOTFILES/packages/linux) &>> $INTALL_LOG
