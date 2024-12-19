#!/bin/bash

NVM_DIR_PATH=$HOME/.nvm
if [ ! -d $NVM_DIR_PATH ]; then
    mkdir $NVM_DIR_PATH
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/HEAD/install.sh)"
    [ -s "$NVM_DIR_PATH/nvm.sh" ] && \. "$NVM_DIR_PATH/nvm.sh"
fi

nvm install --lts
npm install -g @angular/cli
npm install -g typescript
npm install -g ts-node
