#!/bin/bash

sudo dnf install --skip-unavailable -y $(cat $HOME/dotfiles/packages/linux)

source $HOME/dotfiles/scripts/flatpak.sh
source $HOME/dotfiles/scripts/generate_ssh.sh
source $HOME/dotfiles/scripts/git_config.sh
source $HOME/dotfiles/scripts/nvm.sh
source $HOME/dotfiles/scripts/link_configs.sh
