#!/bin/bash

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y $(cat $HOME/dotfiles/packages/flatpak)
