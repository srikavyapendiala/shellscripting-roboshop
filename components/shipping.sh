#!/bin/bash

source components/common.sh
OS_PREREQ

Head "Install maven"
apt install maven -y &>>$LOG


Head "Adding a user"
if [$? -ne 0]; then
   useradd -m -s /bin/bash roboshop
   Stat $?
fi

DOWNLOAD_COMPONENT

Head "Extract Downloaded Archieve"
cd /home/roboshop && unzip /tmp/shipping.zip &>>$LOG  && mv shipping-main shipping && cd /home/roboshop/shipping
&& mvn clean package &>>$LOG && chown roboshop:roboshop /home/roboshop -R && mv target/shipping-1.0.jar shipping.jar &>>$LOG
Stat $?

Head "Copy the service file"
mv /home/roboshop/shipping/systemd.service /etc/systemd/system/shipping.service

Head"start the service"
systemctl daemon-reload
&& systemctl start shipping && systemctl enable shipping