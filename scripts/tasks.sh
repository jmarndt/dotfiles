run_tasks() {
    log $DELIMITER && log "Building list of tasks to be run..."
    TASKS=()
    [[ $IS_WORK = "true" ]] && TASKS+=( "work_config" )
    [[ $PACKAGE_MANAGER = "apt" ]] && TASKS+=( "install_apt_packages" )
    [[ $PACKAGE_MANAGER = "dnf" ]] && TASKS+=( "install_dnf_packages" )
    [[ $PACKAGE_MANAGER = "brew" ]] && TASKS+=( "install_homebrew_packages" )
    [[ $INSTALL_FLATPAK = "true" ]] && TASKS+=( "install_flatpak_packages" )
    [[ $INSTALL_NODE = "true" ]] && TASKS+=( "install_node_packages" )
    [[ $INSTALL_SSH_KEYS = "true" ]] && TASKS+=( "install_ssh_keys" )
    TASKS+=( "link_configuration_files" )
    TASKS+=( "configure_shellrc" )

    log "Task list:"
    for task in ${TASKS[@]}; do
        log "\"$task\""
    done

    for task in ${TASKS[@]}; do
        log $DELIMITER && log "Executing \"$task\"..."
        $task
    done

    log $DELIMITER
    log "Tasks complete, dotfiles are now installed."
}

run_tasks
