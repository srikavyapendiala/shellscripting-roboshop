#!/bin/bash

source components/common.sh
OS_PREREQ

Head "Install npm"
apt install npm -y &>>$LOG
Stat $?

Head "Adding roboshop User"
id roboshop &>>$LOG
if [$? -nq 0]; then
   useradd -m -s /bin/bash roboshop
   Stat $?
fi

DOWNLOAD_COMPONENT

Head"Extracting Downloaded Archieve"
cd /home/roboshop && unzip /tmp/cart.zip  &>>$LOG && mv cart-main cart && cd /home/roboshop/cart && npm install &>>$LOG &&
chown roboshop:roboshop /home/roboshop -R
Stat $?

Head "Update Endpoints in Service file"
sed -i -e "s/REDIS_ENDPOINT/redis.kavya.website/" -e "s/CATALOUGE_ENDPOINT/catalouge.kavya.website/" /home/roboshop/cart/systemd.service
Stat $?

Head"Setup systemd Service"
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service

Head " Restart the service"
systemctl daemon-reload
&& systemctl start cart && systemctl enable cart
Stat $?

