#!/bin/bash

[[ $XDG_CURRENT_DESKTOP = "GNOME" ]] && sudo apt install -y gnome-software-plugin-flatpak
sudo apt install -y $(cat $HOME/dotfiles/packages/linux)
