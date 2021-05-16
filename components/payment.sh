#!/bin/bash

Head "Create a user for running the application"
useradd -m -s /bin/bash roboshop
Stat $?

Head "Switch to Directory"
$ cd /home/roboshop
Stat $?

DOWNLOAD_COMPONENT

Head "Unzip and move"
$ unzip /tmp/payment.zip &>>$LOG
$ mv payment-main payment

source components/common.sh
OS_PREREQ

Head "Install Python Dependency Installer"
apt install python3-pip -y &>>$LOG
Stat $?

Head "Install the dependencies"
cd /home/roboshop/payment
pip3 install -r requirements.txt &>>$LOG

Head "Change the Ip address In service files"
mv /home/roboshop/payment/systemd.service /etc/systemd/system/payment.service
Stat $?

Head "Setup the service"
systemctl daemon-reload
&& systemctl enable payment && systemctl start payment
Stat $?