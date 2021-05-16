#!/bin/bash
source components/common.sh

OS_PREREQ
Head "Setup MOngodb Repositories"
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add - && echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
Stat $?

apt update
Stat $?

Head "Install Mongo & Start Service"
apt install -y mongodb-org &>>$LOG
Stat $?

Head "Update Liste IP address from 127.0.0.1 to 0.0.0.0 in config file"
Config file: /etc/mongod.conf
Stat $?

Head "restart the service"
systemctl restart mongod
Stat $?

DOWNLOAD_COMPONENT

cd /tmp && unzip mongodb.zip &&cd mongodb-main &&mongo < catalogue.js &&mongo < users.js
