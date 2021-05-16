#!/bin/bash

source components/common.sh
OS_PREREQ

Head "Install maven"
apt install maven -y &>>$LOG


Head "Create a user"
useradd -m -s /bin/bash roboshop
Stat $?

Head "Download the repo"
$ cd /home/roboshop
Head "Download the repo"
$ curl -s -L -o /tmp/shipping.zip "https://github.com/zelar-soft-roboshop/shipping/archive/main.zip"
$ unzip /tmp/shipping.zip
$ mv shipping-main shipping
$ cd shipping
$ mvn clean package
$ mv target/shipping-1.0.jar shipping.jar
Copy the service file and start the service.
# mv /home/roboshop/shipping/systemd.service /etc/systemd/system/shipping.service

# systemctl daemon-reload
# systemctl start shipping
# systemctl enable shipping

