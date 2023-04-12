#!/bin/bash
# https://github.com/jmarndt/dotfiles
RED="\033[91m"; GREEN="\033[92m"; YELLOW="\033[93m"; BG_GREEN="\033[42m"; DEFAULT="\033[39m"
BOLD="\033[1m"; UNDERLINE="\033[4m"; BLINK="\033[5m"; BLINK_OFF="\033[25m"
RESET="\033[0m"; CLS="\33c\e[3J"
MSG_BLOCK="################################################################################\n"
MSG_START="                           STARTING BOOTSTRAP\n";MSG_END="                           BOOTSTRAP COMPLETE\n"

DOTFILES_DIR_PATH=~/dotfiles
SSH_KEY_PATH=~/.ssh/id_ed25519
ZSHRC_PATH=~/.zshrc
NVM_DIR_PATH=~/.nvm
WORK_DIR_PATH=~/work
WORK_EMAIL=""

mac_check_terminal_access() {
    if ! plutil -lint /Library/Preferences/com.apple.TimeMachine.plist >/dev/null ; then
        printf $CLS
        printf "$BLINK""WARNING:$BLINK_OFF$BOLD$RED Full Disk Access Required!\n\n"
        printf "$RESET""Open $BG_GREEN""Prefernces > Privacy & Security > Full Disk Access$RESET and enable Terminal\n"
        printf "Then quit Terminal and re-run this script\n\n"
        open "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles"
        exit 1
    fi
}

install_xcode() {
    xcode-select -p &> /dev/null
    if [ $? -ne 0 ]; then
        touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
        PROD=$(softwareupdate -l | grep "\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')
        softwareupdate -i "$PROD" --verbose;
    fi
}

bootstrap() {
    if [[ $OSTYPE == 'darwin'* ]]; then
        mac_check_terminal_access
    fi

    printf $CLS
    printf "$RESET$BOLD$GREEN$MSG_BLOCK$MSG_START$MSG_BLOCK$RESET\n"
    read -p "Work email:  " WORK_EMAIL; printf "\n"

    if [[ $OSTYPE == 'darwin'* ]]; then
        printf "\n$MSG_BLOCK""Installing Xcode Command Line Tools...\n"
        install_xcode
    fi

    printf "\n$MSG_BLOCK""Generating SSH keys...\n"
    if [ ! -f $SSH_KEY_PATH ]; then
        ssh-keygen -t ed25519 -N "" -C "" -f $SSH_KEY_PATH
    fi

    printf "\n$MSG_BLOCK""Configuring work directory...\n"
    if [ ! -d $WORK_DIR_PATH ]; then
        mkdir $WORK_DIR_PATH
        if [ ! -z "$WORK_EMAIL" ]; then
            printf "[user]\n  email = $WORK_EMAIL\n" > $WORK_DIR_PATH/.gitconfig
        fi
    fi

    printf "\n$MSG_BLOCK""Installing Homebrew & packages...\n"
    if test ! $(which brew); then
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    curl https://raw.githubusercontent.com/jmarndt/dotfiles/master/Brewfile --output ./Brewfile.bootstrap
    brew bundle install --file ./Brewfile.bootstrap

    printf "\n$MSG_BLOCK""Installing dotfiles...\n"
    if [ ! -d $DOTFILES_DIR_PATH ]; then
        git clone https://github.com/jmarndt/dotfiles.git $DOTFILES_DIR_PATH
    fi
    /bin/bash $DOTFILES_DIR_PATH/dotfiles.sh

    printf "\n$MSG_BLOCK""Installing NVM...\n"
    if [ ! -d $NVM_DIR_PATH ]; then
        mkdir $NVM_DIR_PATH
    fi
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/HEAD/install.sh)"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    printf "\n$MSG_BLOCK""Installing NodeJS LTS...\n"
    nvm install --lts

    printf "\n$MSG_BLOCK""Installing Angular...\n"
    npm install -g @angular/cli

    printf "\n$MSG_BLOCK""Cleaning up temp files...\n"
    rm ./Brewfile.bootstrap
    rm ./Brewfile.bootstrap.lock.json

    printf "\n$RESET$BOLD$GREEN$MSG_BLOCK$MSG_END$MSG_BLOCK$RESET"
}

bootstrap