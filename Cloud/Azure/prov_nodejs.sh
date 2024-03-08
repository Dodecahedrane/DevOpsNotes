#!/bin/bash

# non interactive (so no multi choice q
export DEBIAN_FRONTEND=noninteractive

# upgrade
sudo apt update

# update
sudo apt upgrade -y

# install nginx
sudo apt install nginx -y

# enable nginx (it should by default.. but should do it just to make sure)
sudo systemctl enable

# install nodejs version 20.x
# https://github.com/nodesource/distributions/blob/master/README.md 
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
sudo apt-get install -y nodejs

# this part assums the source files were copied across to the server
cd app

# install pm2 to run the nodejs server
sudo npm install pm2 -g

# start the app with pm2 (in the background)
pm2 start app.js