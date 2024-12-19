#!/bin/bash

if [[ ! $(cat /proc/version) = *WSL* && ! $(cat /proc/version) = *microsoft* ]]; then
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    sudo flatpak install -y $(cat $HOME/dotfiles/packages/flatpak)
fi
