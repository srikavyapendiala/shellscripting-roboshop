#!/bin/bash
source components/common.sh
OS_PREREQ

Head "Install Nginx"
apt install npm -y &>>$LOG

Head "use roboshop as the username to run the service"
useradd -m -s /bin/bash roboshop
Stat $?

DOWNLOAD_COMPONENT

Head "switch to the roboshop user and run the following commands"
$ cd /home/roboshop
$ unzip /tmp/user.zip
$ mv user-main user
$ cd /home/roboshop/user
$ npm install
Stat $?

Head "update the IP address of MONGODB Server in systemd.service file"
mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service

Head "set up the service with systemctl"
systemctl daemon-reload && systemctl start user
&& systemctl enable user

