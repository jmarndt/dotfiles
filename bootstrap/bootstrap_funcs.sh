CLEAR_SCREEN="\33c\e[3J"
RESET="\033[0m"
DEFAULT="\033[39m"
BOLD="\033[1m"
RED="\033[91m"
GREEN="\033[92m"
MSG_BLOCK=""
WORK_EMAIL=""

print_msg() {
    printf "\n$MSG_BLOCK\n$1\n"
}

print_start_msg() {
    echo "start mac..."
    MSG_BLOCK="##################################################"
    printf "$CLEAR_SCREEN$RESET$BOLD$GREEN$MSG_BLOCK\nSTARTING BOOTSTRAP\n$MSG_BLOCK\n$RESET"
}

print_end_msg() {
    printf "\n$RESET$BOLD$GREEN$MSG_BLOCK\nBOOTSTRAP COMPLETE\n$MSG_BLOCK\n$RESET"
}

verify_mac() {
    if [[ $OSTYPE != 'darwin'* ]]; then
        exit 1
    fi
    if ! plutil -lint /Library/Preferences/com.apple.TimeMachine.plist >/dev/null ; then
        printf $CLEAR_SCREEN$BOLD$RED
        printf "WARNING: Full Disk Access Required!$RESET\n\n"
        printf "Open $BOLD$GREEN""Prefernces > Privacy & Security > Full Disk Access$RESET and enable Terminal\n"
        printf "Then quit Terminal and re-run this script\n\n"
        open "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles"
        exit 1
    fi
}

gather_user_info() {
    read -p "Work email: " WORK_EMAIL
}

install_xcode() {
    print_msg "Installing Xcode Command Line Tools..."
    xcode-select -p &> /dev/null
    if [ $? -ne 0 ]; then
        touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
        PROD=$(softwareupdate -l | grep "\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')
        softwareupdate -i "$PROD" --verbose;
    fi
}

generate_ssh_keys() {
    print_msg "Generating SSH keys..."
    SSH_KEY_PATH=~/.ssh/id_ed25519
    if [ ! -f $SSH_KEY_PATH ]; then
        ssh-keygen -t ed25519 -N "" -C "" -f $SSH_KEY_PATH
    fi
}

configure_work_git() {
    print_msg "Configuring work directory..."
    WORK_DIR_PATH=~/work
    if [ ! -d $WORK_DIR_PATH ]; then
        mkdir $WORK_DIR_PATH
        if [ ! -z "$WORK_EMAIL" ]; then
            printf "[user]\n  email = $WORK_EMAIL\n" > $WORK_DIR_PATH/.gitconfig
        fi
    fi
}

install_homebrew() {
    print_msg "Installing Homebrew & packages..."
    BREW_FILE="Brewfile"
    if test ! $(which brew); then
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        curl https://raw.githubusercontent.com/jmarndt/dotfiles/master/$BREW_FILE --output ./$BREW_FILE.bootstrap
        brew bundle install --file ./$BREW_FILE.bootstrap
        rm ./$BREW_FILE.bootstrap
        rm ./$BREW_FILE.bootstrap.lock.json
    fi
}

install_dotfiles() {
    print_msg "Installing dotfiles..."
    DOTFILES_DIR_PATH=~/dotfiles
    if [ ! -d $DOTFILES_DIR_PATH ]; then
        git clone https://github.com/jmarndt/dotfiles.git $DOTFILES_DIR_PATH
    fi
    /bin/bash $DOTFILES_DIR_PATH/dotfiles.sh
}

install_dev_tools() {
    print_msg "Installing dev tools..."
    NVM_DIR_PATH=~/.nvm
    if [ ! -d $NVM_DIR_PATH ]; then
        mkdir $NVM_DIR_PATH
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/HEAD/install.sh)"
        [ -s "$NVM_DIR_PATH/nvm.sh" ] && \. "$NVM_DIR_PATH/nvm.sh"
        nvm install --lts
        npm install -g @angular/cli
    fi
}

bootstrap_mac() {
    verify_mac
    print_start_msg
    gather_user_info
    install_xcode
    generate_ssh_keys
    configure_work_git
    install_homebrew
    install_dotfiles
    install_dev_tools
    print_end_msg
}

bootstrap_deb() {
    # TODO
}

bootstrap() {
    case $1 in
    "deb")
        bootstrap_deb
        ;;
    "mac")
        bootstrap_mac
        ;;
    esac
}