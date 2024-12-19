#!/bin/bash

if test ! $(which brew); then
    TITLE="INSTALLING HOMEBREW"
    COMMAND="NONINTERACTIVE=1 /bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    log_title

    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

TITLE="INSTALLING HOMEBREW PACKAGES"
COMMAND="brew bundle install --file $HOME/dotfiles/packages/brew"
log_title

brew bundle install --file $HOME/dotfiles/packages/brew &>> $INTALL_LOG
rm $HOME/dotfiles/packages/brew.lock.json
