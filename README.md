# dotfiles
This repo holds my custom program configuraiton files.

# install dotfiles
Simply run the `propagate_dotfiles.sh` script included in this repo. This will backup any existing configurations if they exist, then link the respective config files to the ones in this repo.
It will also create an export for the path of this repo on the local machine that is sourced at the beginning of the shell rc file so that various aliases work properly, and so that the path of the repo on the local machine is irrelevant.
