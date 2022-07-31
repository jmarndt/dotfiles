#!/bin/sh

# get dotfile repo directory
DOTFILES_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
BACKUP_DIR=$HOME/.backup_dotfiles
[ ! -d "$BACKUP_DIR" ] && mkdir $BACKUP_DIR


# .zshrc
ZSHRC_FILE=$HOME/.zshrc
[ -L "$ZSHRC_FILE" ] && rm $ZSHRC_FILE
[ -f "$ZSHRC_FILE" ] && mv $ZSHRC_FILE $BACKUP_DIR/.zshrc.bak.$(date +%m%d%Y-%H%M%S)
ln -s $DOTFILES_DIR/zsh/zshrc $ZSHRC_FILE


# .vimrc
VIMRC_FILE=$HOME/.vimrc
[ -L "$VIMRC_FILE" ] && rm $VIMRC_FILE
[ -f "$VIMRC_FILE" ] && mv $VIMRC_FILE $BACKUP_DIR/.vimrc.bak.$(date +%m%d%Y-%H%M%S)
ln -s $DOTFILES_DIR/vim/vimrc $VIMRC_FILE


# .tmux.conf
TMUX_FILE=$HOME/.tmux.conf
[ -L "$TMUX_FILE" ] && rm $TMUX_FILE
[ -f "$TMUX_FILE" ] && mv $TMUX_FILE $BACKUP_DIR/.tmux.conf.bak.$(date +%m%d%Y-%H%M%S)
ln -s $DOTFILES_DIR/tmux/tmux.conf $TMUX_FILE


# .gitconfig
GIT_FILE=$HOME/.gitconfig
[ -L "$GIT_FILE" ] && rm $GIT_FILE
[ -f "$GIT_FILE" ] && mv $GIT_FILE $BACKUP_DIR/.gitconfig.bak.$(date +%m%d%Y-%H%M%S)
ln -s $DOTFILES_DIR/git/gitconfig $GIT_FILE


# finish 
COMPLETE_MSG="dotfiles installed! don't forget to source your rc files!"
if [ ! "$(ls -A $BACKUP_DIR)" ]; then
  rm -rf $BACKUP_DIR
  echo $COMPLETE_MSG
else
  echo "existing dotfiles were found. backups were made to $BACKUP_DIR"
  echo $COMPLETE_MSG
fi
