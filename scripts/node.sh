#!/bin/bash

NVM_DIR_PATH=$HOME/.nvm
if [ ! -d $NVM_DIR_PATH ]; then
    mkdir $NVM_DIR_PATH
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/HEAD/install.sh)"
fi

[ -s "$NVM_DIR_PATH/nvm.sh" ] && \. "$NVM_DIR_PATH/nvm.sh"

nvm install --lts
npm install -g @angular/cli
npm install -g typescript
npm install -g ts-node
