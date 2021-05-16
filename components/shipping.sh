#!/bin/bash

source components/common.sh
OS_PREREQ

Head "Install maven"
apt install maven -y &>>$LOG


Head "Create a user"
useradd -m -s /bin/bash roboshop
Stat $?

Head "switch to directory"
$ cd /home/roboshop

DOWNLOAD_COMPONENT

Head "Unzip all files"
$ unzip /tmp/shipping.zip
$ mv shipping-main shipping
$ cd shipping
$ mvn clean package
$ mv target/shipping-1.0.jar shipping.jar
Stat $?

Head "Copy the service file"
mv /home/roboshop/shipping/systemd.service /etc/systemd/system/shipping.service

Head"start the service"
systemctl daemon-reload
&& systemctl start shipping && systemctl enable shipping