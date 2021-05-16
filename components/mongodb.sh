#!/bin/bash
source components/common.sh

Head "Setup MOngodb Repositories"
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add - && echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
Stat $?

OS_PREREQ

Head "Install Mongo & Start Service"
apt install -y mongodb-org &>>$LOG
Stat $?

Head "Update Listen IP address"
sed -i -e "s/127.0.0.1/0.0.0.0/" /etc/mongod.conf
Stat $?

Head "restart the service"
systemctl restart mongod && systemctl enable mongod
Stat $?

DOWNLOAD_COMPONENT

Head "Extract Downloaded Archieve"
cd /tmp && unzip mongodb.zip &>>$LOG && cd mongodb-main

&&mongo < catalogue.js &&mongo < users.js
Stat $?