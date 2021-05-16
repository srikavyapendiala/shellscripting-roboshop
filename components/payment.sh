#!/bin/bash
source components/common.sh
OS_PREREQ

Head "Adding robhoshop user"
if [$? -ne 0]; then
   useradd -m -s /bin/bash roboshop
   Stat $?
fi

DOWNLOAD_COMPONENT

Head "Install Python Dependency Installer"
apt install python3-pip -y &>>$LOG
Stat $?

Head "Extract Downloaded archieve"
cd /home/roboshop && unzip /tmp/payment.zip &>>$LOG && mv payment-main payment &&cd /home/roboshop/payment
&& pip3 install -r requirements.txt &>>$LOG && chown roboshop:roboshop /home/roboshop -R
Stat $?

Head "Change the Ip address In service files"
mv /home/roboshop/payment/systemd.service /etc/systemd/system/payment.service
Stat $?

Head "Setup the service"
systemctl daemon-reload
&& systemctl enable payment && systemctl start payment
Stat $?
