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
DOTFILES_DB=$HOME/dotfiles/dotfiles.db
DOTFILES_LOG=$HOME/.dotfiles_install.log
DOTFILES_CONTEXT_FILE=$DOTFILES_DIR/dotfiles.context

log() {
    if [ "$1" = "terminal" ]; then echo -e "$2"
    elif  [ "$1" = "file" ]; then echo -e "$2" &>> $DOTFILES_LOG
    else echo -e "$1" 2>&1 | tee -a $DOTFILES_LOG; fi
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
        log "\nError getting dotfiles, quitting.\n" && exit 1
    fi
fi
log "Found dotfiles located in $DOTFILES_DIR\n"

source $DOTFILES_DIR/scripts/helpers.sh
source $DOTFILES_DIR/scripts/context.sh
source $DOTFILES_DIR/scripts/tasks.sh

log "Run 'source $SYSTEM_RC' to reload terminal"
