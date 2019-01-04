#!/bin/sh
sudo apt-get update
sh ../Docker.sh
sudo apt-get install nodejs npm
sudo apt-get install npm
sudo apt-get install build-essential libssl-dev -y
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install --lts
nodejs --version
npm --version
nvm --version
docker --version