# dotfiles
This repo holds my custom program configuraiton files.

# install dotfiles
Simply run the `propagate_dotfiles.sh` script included in this repo.
The script will backup any existing configurations if they exist, then link the respective config files to the ones in this repo.
It will also create a file in the home directory with an export for the path of this repo on the local machine. This file is sourced at the beginning of the shell rc file so that various aliases work properly, and so that the location of the repo is irrelevant and can be moved at any time. just rerun the propagate script anytime the location of the files changes for this to be properly updated.
