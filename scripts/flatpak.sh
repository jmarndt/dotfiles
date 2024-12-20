#!/bin/bash

if [[ ! $FLAG == "--no-flatpak" && ! $FLAG == "server" && ! $(cat /proc/version) = *WSL* && ! $(cat /proc/version) = *microsoft* ]]; then
    TITLE="INSTALLING FLATPAK PACKAGES"
    COMMAND="sudo flatpak install -y $(cat $HOME/dotfiles/packages/flatpak)"
    log_title

    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo &>> $INTALL_LOG
    sudo flatpak install -y $(cat $HOME/dotfiles/packages/flatpak) &>> $INTALL_LOG
fi
