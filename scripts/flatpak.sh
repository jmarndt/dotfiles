#!/bin/bash

if ! [ -x "$(command -v flatpak)" ]; then
    sudo apt install flatpak
fi
[[ $XDG_CURRENT_DESKTOP = "GNOME" ]] && sudo apt install gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y $(cat $HOME/dotfiles/packages/flatpak)
