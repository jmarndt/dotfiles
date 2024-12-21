# #!/bin/bash

# DOTFILES=$HOME/dotfiles
# INTALL_LOG=$HOME/.dotfiles_install.log
# FLAG=$1
# BANNER="
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# ░░                                                                  ░░
# ░░   ██████╗  █████╗ ████████╗███████╗██╗██╗     ███████╗███████╗   ░░
# ░░   ██╔══██╗██╔══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝   ░░
# ░░   ██║  ██║██║  ██║   ██║   █████╗  ██║██║     █████╗  ███████╗   ░░
# ░░   ██║  ██║██║  ██║   ██║   ██╔══╝  ██║██║     ██╔══╝   ╚═══██╗   ░░
# ░░   ██████╔╝╚█████╔╝   ██║   ██║     ██║███████╗███████╗███████║   ░░
# ░░   ╚═════╝  ╚════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝   ░░
# ░░                                                                  ░░
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# "
# RESET="\033[0m" DEFAULT="\033[39m" BOLD="\033[1m" RED="\033[91m" GREEN="\033[92m" CLEAR_SCREEN="\33c\e[3J"
# DIVIDER="======================================================================"

# log_title() {
#     echo -e "\n$DIVIDER\n$TITLE" 2>&1 | tee -a $INTALL_LOG
#     echo -e "Command: $COMMAND\n\nOUTPUT:\n-------\n" &>> $INTALL_LOG
# }

# printf $CLEAR_SCREEN
# echo -e "$GREEN$BANNER$RESET" && echo -e "$BANNER" > $INTALL_LOG
# echo -e "$BOLD""Detailed installation logs: '$INTALL_LOG'$RESET"
# [ -f /etc/os-release ] && source /etc/os-release

# if [ ! -d $DOTFILES ]; then
#     TITLE="CLONING DOTFILES REPOSITORY"
#     COMMAND="git clone https://github.com/jmarndt/dotfiles.git $DOTFILES"
#     log_title

#     git clone https://github.com/jmarndt/dotfiles.git $DOTFILES &>> $INTALL_LOG
# fi
# if [[ $PRETTY_NAME = *Debian* || $PRETTY_NAME = *Ubuntu* ]]; then
#     source $DOTFILES/scripts/apt.sh
#     source $DOTFILES/scripts/flatpak.sh
# fi
# if [[ $PRETTY_NAME = *Fedora* ]]; then
#     source $DOTFILES/scripts/dnf.sh
#     source $DOTFILES/scripts/flatpak.sh
# fi
# if [[ $OSTYPE = 'darwin'* ]]; then
#     source $DOTFILES/scripts/macos.sh
#     source $DOTFILES/scripts/homebrew.sh
# fi

# source $DOTFILES/scripts/ssh.sh
# source $DOTFILES/scripts/git.sh
# source $DOTFILES/scripts/node.sh
# source $DOTFILES/scripts/link.sh

# echo -e "$BOLD\nComplete, dotfiles are now installed!\n$RESET"


BANNER="
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░                                                                  ░░
░░   ██████╗  █████╗ ████████╗███████╗██╗██╗     ███████╗███████╗   ░░
░░   ██╔══██╗██╔══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝   ░░
░░   ██║  ██║██║  ██║   ██║   █████╗  ██║██║     █████╗  ███████╗   ░░
░░   ██║  ██║██║  ██║   ██║   ██╔══╝  ██║██║     ██╔══╝   ╚═══██╗   ░░
░░   ██████╔╝╚█████╔╝   ██║   ██║     ██║███████╗███████╗███████║   ░░
░░   ╚═════╝  ╚════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝   ░░
░░                                                                  ░░
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
"

DOTFILES_VERION=2.0.0
DOTFILES_DIR=$HOME/dotfiles
DOTFILES_ARGS="$@"
DOTFILES_LOG=$HOME/.dotfiles_install.log

log() {
    if [ "$1" = "terminal" ]; then
        echo -e "$2"
    elif  [ "$1" = "file" ]; then
        echo -e "$2" &>> $DOTFILES_LOG
    else
        echo -e "$1" 2>&1 | tee -a $DOTFILES_LOG
    fi
}

printf "\33c\e[3J" && echo -n '' > $DOTFILES_LOG
log terminal "\033[92m$BANNER\033[0m" && log file "$BANNER"
log "Version $DOTFILES_VERION"
log "Detailed logs: $DOTFILES_LOG"
log "Confirming dotfiles are present..."
if [[ ! -d $DOTFILES_DIR ]]; then
    log file "No dotfiles found in $DOTFILES_DIR"
    log file "Trying to clone repository..."
    git clone https://github.com/jmarndt/dotfiles.git $DOTFILES_DIR &>> $DOTFILES_LOG
    if [[ ! -d $DOTFILES_DIR ]]; then
        log "\nError getting dotfiles, quitting.\n"
        exit 1
    fi
fi
log "Found dotfiles located in $DOTFILES_DIR\n"

source $DOTFILES_DIR/scripts/variables.sh

source $DOTFILES_DIR/scripts/context.sh
# build_instructions
# execute_instructions
