gather_context() {
    log "$DELIMITER"
    if [[ $# = 0 && -f $DOTFILES_CONTEXT_FILE ]]; then
        log "Existing context found" && log file "$(cat $DOTFILES_CONTEXT_FILE)"
        source $DOTFILES_CONTEXT_FILE
    else
        create_context $@
    fi
}

create_context() {
    log "Creating new context..."
    [ -f /etc/os-release ] && source /etc/os-release
    [[ $PRETTY_NAME = *Debian* || $PRETTY_NAME = *Ubuntu* ]] && PACKAGE_MANAGER="apt"
    [[ $PRETTY_NAME = *Fedora* ]] && PACKAGE_MANAGER="dnf"
    [[ $OSTYPE = 'darwin'* ]] && PACKAGE_MANAGER="brew"

    if [[ ! $# = 0 && !($# = 1 && $@ = *-d* || $@ = *--default*) ]]; then
        IS_SERVER=$([[ $@ = *-s* || $@ = *--server* ]] && echo "true" || echo "false")
        INSTALL_FLATPAK=$([[ $@ = *-f* || $@ = *--flatpak* && ! $PACKAGE_MANAGER = "brew" ]] && echo "true" || echo "false")
        INSTALL_GIT_CONF=$([[ $@ = *-g* || $@ = *--git* ]] && echo "true" || echo "false")
        INSTALL_SSH_KEYS=$([[ $@ = *-S* || $@ = *--ssh* ]] && echo "true" || echo "false")
        INSTALL_NODE=$([[ $@ = *-n* || $@ = *--node* ]] && echo "true" || echo "false")
    fi

    echo -e "PACKAGE_MANAGER=$PACKAGE_MANAGER\nIS_SERVER=$IS_SERVER\nINSTALL_FLATPAK=$INSTALL_FLATPAK\nINSTALL_GIT_CONF=$INSTALL_GIT_CONF\nINSTALL_SSH_KEYS=$INSTALL_SSH_KEYS\nINSTALL_NODE=$INSTALL_NODE" > $DOTFILES_CONTEXT_FILE
    log "New context created" && log file "$(cat $DOTFILES_CONTEXT_FILE)\n"
}

gather_context $@
