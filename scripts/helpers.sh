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
INSTALL_FLATPAK="true"
INSTALL_GIT_CONF="false"
INSTALL_SSH_KEYS="true"
INSTALL_NODE="true"

install_apt_packages() {
    sudo apt install -y $(cat $DOTFILES_DIR/packages/linux) &>> $DOTFILES_LOG
}

install_dnf_packages() {
    sudo dnf install --skip-unavailable -y $(cat $DOTFILES_DIR/packages/linux) &>> $DOTFILES_LOG
}

install_homebrew_packages() {
    if test ! $(which brew); then
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &>> $DOTFILES_LOG
    fi
    brew bundle install --file $DOTFILES_DIR/packages/brew &>> $INTALL_LOG
    rm $DOTFILES_DIR/packages/brew.lock.json
}

install_flatpak_packages() {
    sudo $PACKAGE_MANAGER install -y flatpak &>> $DOTFILES_LOG
    [[ $XDG_CURRENT_DESKTOP = "GNOME" ]] && sudo $PACKAGE_MANAGER install -y gnome-software-plugin-flatpak &>> $DOTFILES_LOG
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo &>> $DOTFILES_LOG
    sudo flatpak install -y $(cat $HOME/dotfiles/packages/flatpak) &>> $DOTFILES_LOG
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
        log file "Existing key found at $SSH_KEY_PATH, skipping key generation"
    fi
}

install_git_conf() {
    GIT_DIR=$HOME/git
    if [[ ! -d $GIT_DIR ]]; then
        log file "Creating $GIT_DIR/"
        mkdir $GIT_DIR
        log file "Creating $GIT_DIR/.gitconfig, be sure to update with correct email"
        printf "[user]\n  email = replace@me.com\n" > $GIT_DIR/.gitconfig
    fi
    log file "$GIT_DIR/ is now ready"
}

link_configuration_files() {
    ## Refactor to more flexible path options
    dotfiles=("vimrc" "sqliterc" "gitconfig" "stignore" "tmux.conf")
    for dotfile in ${dotfiles[@]}; do
        [[ -L $HOME/.$dotfile || -f $HOME/.$dotfile ]] && rm $HOME/.$dotfile
        ln -s $DOTFILES_DIR/configs/$dotfile $HOME/.$dotfile
    done
}

configure_shellrc() {
    SYSTEM_RC=""
    SHELL_CONF=""
    if [[ $SHELL = "/bin/zsh" ]]; then
        SYSTEM_RC=$HOME/.zshrc
        eval "$(direnv hook zsh)"
    fi
    if [[ $SHELL = "/bin/bash" ]]; then
        SYSTEM_RC=$HOME/.bashrc
        eval "$(direnv hook bash)"
    fi

    RC_SOURCE_LINE="source $DOTFILES_DIR/configs/shellrc"
    [ -f $SYSTEM_RC ] && grep -v "$RC_SOURCE_LINE" $SYSTEM_RC > temp && mv temp $SYSTEM_RC
    echo $RC_SOURCE_LINE >> $SYSTEM_RC
}
