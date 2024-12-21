OVERWRITE=null          # true | false      # -o | --overwrite
SERVER=null             # true | false      # -s | --server
FLATPAK=null            # true | false      # -f | --flatpak
GIT=null                # true | false      # -g | --git
SSH=null                # true | false      # -S | --ssh
NODE=null               # true | false      # -n | --node
PACKAGE_MANAGER=null    # apt | dnf | brew

CONTEXT_FILE=$DOTFILES_DIR/dotfiles.context

parse_args() {
    ARG_COUNT=0
    for arg in $DOTFILES_ARGS
    do
        ARG_COUNT=$ARG_COUNT+1
        case $arg in
            -o | --overwrite | --override) echo "OVERWRITE" ;;
            -s | --server) echo "SERVER" ;;
            -f | --flatpak) echo "FLATPAK" ;;
            -g | --git) echo "GIT" ;;
            -S | --ssh) echo "SSH" ;;
            -n | --node) echo "NODE" ;;
        esac
    done

    echo $ARG_COUNT

    if [[ $ARG_COUNT = 0 ]]; then
        echo "No Args"
    else
        echo "Has Args"
    fi
}

gather_context() {
    echo "GATHER"
    # if [[ ! -f $CONTEXT_FILE ]]; then
    #     echo "No context found"
    #     touch $CONTEXT_FILE
    # else
    #     source $CONTEXT_FILE
    #     echo $DOT_TEST
    # fi



#     # if [[ $# -ne 1 ]]; then
#     #     echo "TEST"
#     # fi
#     # for arg in "$@"
#     # do
#     #   echo $arg
#     # done

#     # log file "Install called with $# arguments"
#     # log file "$DELIM"
#     # echo $@
}

parse_args
gather_context

# echo ${CONTEXT[@]}
# echo ${!CONTEXT[@]}
# echo ${CONTEXT["SERVER"]}

# for key in ${!CONTEXT[@]}
# do
#   echo "${key}, ${CONTEXT[${key}]}"
# done
