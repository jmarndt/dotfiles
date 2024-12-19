#!/bin/bash

[[ $XDG_CURRENT_DESKTOP = "GNOME" ]] && sudo dnf install --skip-unavailable -y gnome-software-plugin-flatpak
sudo dnf install --skip-unavailable -y $(cat $HOME/dotfiles/packages/linux)
