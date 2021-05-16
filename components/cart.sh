#!/bin/bash
source components/common.sh
OS_PREREQ

Head "Install Nodejs "
apt install npm -y
Stat $?

Head "use roboshop as the username"
useradd -m -s /bin/bash roboshop
Stat $?

DOWNLOAD_COMPONENT

Head"switch to the roboshop user"
$ cd /home/roboshop
$ unzip /tmp/cart.zip
$ mv cart-main cart
$ cd /home/roboshop/cart
$ npm install
Stat $?

Head "update the IP address of MONGODB Server in systemd.service file"
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service

Head"set up the service with systemctl"
systemctl daemon-reload && systemctl start cart
&& systemctl enable cart
