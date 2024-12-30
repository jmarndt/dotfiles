gather_context() {
    log "$DELIMITER"
    if [[ $# = 0 && -f $DOTFILES_CONTEXT_FILE ]]; then
        log "Existing context found" && log file "$(cat $DOTFILES_CONTEXT_FILE)"
        source $DOTFILES_CONTEXT_FILE
    else
        log "Creating new context..."
        create_context $@
    fi

    build_pgk_queries
    which_shell
}

create_context() {
    [ -f /etc/os-release ] && source /etc/os-release
    [[ $PRETTY_NAME = *Debian* || $PRETTY_NAME = *Ubuntu* ]] && PACKAGE_MANAGER="apt" && PKG_IGNORE_FLAG="--ignore-missing" && PKG_YES_FLAG="-y"
    [[ $PRETTY_NAME = *Fedora* ]] && PACKAGE_MANAGER="dnf" && PKG_IGNORE_FLAG="--skip-unavailable" && PKG_YES_FLAG="-y"
    [[ $OSTYPE = 'darwin'* ]] && PACKAGE_MANAGER="brew"

    if [[ ! $# = 0 && !($# = 1 && $@ = *-d* || $@ = *--default*) ]]; then
        IS_SERVER=$([[ $@ = *-s* || $@ = *--server* ]] && echo "true" || echo "false")
        IS_WORK=$([[ $@ = *-w* || $@ = *--work* ]] && echo "true" || echo "false")
        INSTALL_FLATPAK=$([[ $@ = *-f* || $@ = *--flatpak* && ! $PACKAGE_MANAGER = "brew" ]] && echo "true" || echo "false")
        INSTALL_SSH_KEYS=$([[ $@ = *-S* || $@ = *--ssh* ]] && echo "true" || echo "false")
        INSTALL_NODE=$([[ $@ = *-n* || $@ = *--node* ]] && echo "true" || echo "false")
    fi

    echo -e "PACKAGE_MANAGER=$PACKAGE_MANAGER\nIS_SERVER=$IS_SERVER\nIS_WORK=$IS_WORK\nINSTALL_FLATPAK=$INSTALL_FLATPAK\nINSTALL_SSH_KEYS=$INSTALL_SSH_KEYS\nINSTALL_NODE=$INSTALL_NODE" > $DOTFILES_CONTEXT_FILE
    log "New context created" && log file "$(cat $DOTFILES_CONTEXT_FILE)\n"
}

build_pgk_queries() {
    PKG_QUERY="SELECT $PACKAGE_MANAGER FROM packages WHERE $PACKAGE_MANAGER IS NOT NULL "
    FLATPAK_QUERY="SELECT flatpak FROM packages WHERE flatpak IS NOT NULL "

    if [[ $IS_SERVER = "true" ]]; then
        PKG_QUERY+="AND for_server = $IS_SERVER "
        FLATPAK_QUERY+="AND for_server = $IS_SERVER "
    fi

    if [[ $IS_WORK = "true" ]]; then
        PKG_QUERY+="AND for_work = $IS_WORK "
        FLATPAK_QUERY+="AND for_work = $IS_WORK "
    fi

    PKG_QUERY+="ORDER BY name;"
    FLATPAK_QUERY+="ORDER BY name;"

    log file "SQL query used for installing system packages:\n\"$PKG_QUERY\"\n"
    [[ $INSTALL_FLATPAK = "true" ]] && log file "SQL query used for installing Flatpaks:\n\"$FLATPAK_QUERY\""
}

which_shell() {
    [[ $SHELL = "/bin/zsh" ]] && SYSTEM_SHELL="zshrc"
    [[ $SHELL = "/bin/bash" ]] && SYSTEM_SHELL="bashrc"
}

gather_context $@
