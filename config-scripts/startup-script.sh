#!/bin/bash

#Update and install ruby
sudo apt update
sudo apt upgrade -y
sudo apt install -y ruby-full ruby-bundler build-essential

#Install mongodb
wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt update
sudo apt install mongodb-org -y
sudo systemctl start mongod
sudo systemctl enable mongod

#Git clone and build reddit
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
