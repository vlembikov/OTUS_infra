#!/bin/bash

#Update and install ruby
sudo apt update
sudo apt upgrade -y
sudo apt install -y ruby-full ruby-bundler build-essential

#Install mongodb
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E52529D4
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" > /etc/apt/sources.list.d/mongodb-org-4.0.list'
sudo apt update
sudo apt install mongodb-org -y
sudo systemctl start mongod
sudo systemctl enable mongod

#Git clone and build reddit
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
