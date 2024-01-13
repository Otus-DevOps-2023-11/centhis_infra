#!/bin/bash

while ps ax | grep -i [a]pt ; do sleep 10; done;

set -e
APP_DIR=${1:-$HOME}
echo "install git"
sudo apt-get install -y git
echo "git clone"
git config --global http.sslVerify false
git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
cd $APP_DIR/reddit
bundle install
sudo mv /tmp/reddit.service /etc/systemd/system/reddit.service
sudo systemctl start reddit
sudo systemctl enable reddit
