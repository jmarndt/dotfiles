# Terminal font controls
RESET="\033[0m"
DEFAULT="\033[39m"
BOLD="\033[1m"
RED="\033[91m"
GREEN="\033[92m"

# Formatting
DELIMITER="----------------------------------------------------------------------"

# Default context
IS_SERVER="false"
IS_WORK="false"
INSTALL_FLATPAK="true"
INSTALL_SSH_KEYS="true"
INSTALL_NODE="true"

install_apt_packages() {
    sudo apt install -y sqlite3 &>> $DOTFILES_LOG
    sudo apt install --ignore-missing -y $(sqlite3 -init /dev/null -batch $DOTFILES_DB "$PKG_QUERY") &>> $DOTFILES_LOG
}

install_dnf_packages() {
    sudo dnf install -y sqlite3 &>> $DOTFILES_LOG
    sudo dnf install --skip-unavailable -y $(sqlite3 -init /dev/null -batch $DOTFILES_DB "$PKG_QUERY") &>> $DOTFILES_LOG
}

install_homebrew_packages() {
    TEMP_BREW_FILE=$DOTFILES_DIR/brew.tmp
    echo "tap \"homebrew/bundle\"\ntap \"homebrew/cask\"\ntap \"homebrew/core\"" > $TEMP_BREW_FILE
    if test ! $(which brew); then
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &>> $DOTFILES_LOG
    fi
    sqlite3 -init /dev/null -batch $DOTFILES_DB "$PKG_QUERY" >> $TEMP_BREW_FILE
    brew bundle install --file $TEMP_BREW_FILE &>> $INTALL_LOG
    rm $TEMP_BREW_FILE
    rm $TEMP_BREW_FILE.lock.json
}

install_flatpak_packages() {
    TEMP_FLATPAK_FILE=$DOTFILES_DIR/flatpak.tmp
    sudo $PACKAGE_MANAGER install -y flatpak &>> $DOTFILES_LOG
    [[ $XDG_CURRENT_DESKTOP = "GNOME" ]] && sudo $PACKAGE_MANAGER install $PKG_IGNORE_FLAG -y gnome-software-plugin-flatpak &>> $DOTFILES_LOG
    sqlite3 -init /dev/null -batch $DOTFILES_DB "$FLATPAK_QUERY" >> $TEMP_FLATPAK_FILE
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo &>> $DOTFILES_LOG
    sudo flatpak install -y $(cat $TEMP_FLATPAK_FILE) &>> $DOTFILES_LOG
    rm $TEMP_FLATPAK_FILE
}

install_node_packages() {
    NVM_DIR_PATH=$HOME/.nvm
    if [[ ! -d $NVM_DIR_PATH ]]; then
        mkdir $NVM_DIR_PATH && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/HEAD/install.sh)" &>> $DOTFILES_LOG
    fi
    [ -s "$NVM_DIR_PATH/nvm.sh" ] && \. "$NVM_DIR_PATH/nvm.sh"
    nvm install --lts &>> $DOTFILES_LOG
    npm install -g @angular/cli &>> $DOTFILES_LOG
    npm install -g typescript &>> $DOTFILES_LOG
    npm install -g ts-node &>> $DOTFILES_LOG
}

install_ssh_keys() {
    SSH_KEY_PATH=$HOME/.ssh/id_ed25519
    if [[ ! -f $SSH_KEY_PATH ]]; then
        log file "Generating SSH keys at $SSH_KEY_PATH"
        ssh-keygen -t ed25519 -N "" -f $SSH_KEY_PATH &>> $DOTFILES_LOG
    else
        log file "Existing key \"$SSH_KEY_PATH\" found, skipping key generation"
    fi
}

work_config() {
    GIT_DIR=$HOME/git
    if [[ ! -d $GIT_DIR ]]; then
        read -p "Enter work email: " work_email
        log file "Creating $GIT_DIR/"
        mkdir $GIT_DIR
        log file "Creating $GIT_DIR/.gitconfig, be sure to update with correct email"
        printf "[user]\n  email = $work_email\n" > $GIT_DIR/.gitconfig
    fi
    log file "$GIT_DIR/ has been configured"
}

link_configuration_files() {
    DOTFILE_CONFS=$(sqlite3 -init /dev/null -batch $DOTFILES_DB "SELECT name FROM dotfiles;")
    for dotfile in ${DOTFILE_CONFS}; do
        target=$HOME/$(sqlite3 -init /dev/null -batch $DOTFILES_DB "SELECT target FROM dotfiles WHERE name = '$dotfile';")
        config=$DOTFILES_DIR/$(sqlite3 -init /dev/null -batch $DOTFILES_DB "SELECT config FROM dotfiles WHERE name = '$dotfile';")

        [[ -L $target || -f $target ]] && rm $target
        ln -s $config $target
        log file "Linking \"$config\" to \"$target\""
    done
}

configure_shellrc() {
    SHELL_DIR=$DOTFILES_DIR/configs/shells
    if [[ $IS_SERVER = "true" ]]; then
        SHELL_CONFIG=$SHELL_DIR/server_$SYSTEM_SHELL
    else
        SHELL_CONFIG=$SHELL_DIR/desktop_$SYSTEM_SHELL
    fi

    SYSTEM_RC="$HOME/.$SYSTEM_SHELL"
    SOURCE_LINE="source $SHELL_CONFIG"
    grep -v "$DOTFILES_DIR" $SYSTEM_RC > temp && mv temp $SYSTEM_RC
    echo $SOURCE_LINE >> $SYSTEM_RC
    log file "Added \"$SHELL_CONFIG\" to \"$SYSTEM_RC\""
}
