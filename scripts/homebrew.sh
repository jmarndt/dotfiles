#!/bin/bash

if test ! $(which brew); then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
brew bundle install --file $HOME/dotfiles/packages/brew
rm $HOME/dotfiles/packages/brew.lock.json
