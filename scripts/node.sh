#!/bin/bash

NVM_DIR_PATH=$HOME/.nvm

if [[ ! -d $NVM_DIR_PATH && ! $FLAG == "server" ]]; then
    TITLE="INSTALLING NODE VERSION MANAGER"
    COMMAND="mkdir $NVM_DIR_PATH && /bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/HEAD/install.sh)\""
    log_title

    mkdir $NVM_DIR_PATH && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/HEAD/install.sh)" &>> $INTALL_LOG
fi

if [[ ! $FLAG == "server" ]]; then
    [ -s "$NVM_DIR_PATH/nvm.sh" ] && \. "$NVM_DIR_PATH/nvm.sh"

    TITLE="INSTALLING NODE LTS, ANGULAR, TYPESCRIPT, TS-NODE"
    COMMAND="nvm install --lts"
    log_title

    nvm install --lts &>> $INTALL_LOG
    npm install -g @angular/cli &>> $INTALL_LOG
    npm install -g typescript &>> $INTALL_LOG
    npm install -g ts-node &>> $INTALL_LOG
fi
