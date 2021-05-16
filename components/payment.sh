#!/bin/bash

Head "Create a user for running the application"
useradd -m -s /bin/bash roboshop
Stat $?

Head "Switch to Directory"
$ cd /home/roboshop
Stat $?

DOWNLOAD_COMPONENT

$ unzip /tmp/payment.zip
$ mv payment-main payment

Install Python Dependency Installer
# apt update
# apt install python3-pip -y
Install the dependencies
# cd /home/roboshop/payment
# pip3 install -r requirements.txt
Note: Above command may fail with permission denied, So run as root user

Update the roboshop user and group id in payment.ini file.

Setup the service

# mv /home/roboshop/payment/systemd.service /etc/systemd/system/payment.service
# systemctl daemon-reload
# systemctl enable payment
# systemctl start payment