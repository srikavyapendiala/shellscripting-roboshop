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
cd /home/roboshop && unzip /tmp/catalogue.zip  &>>$LOG && mv catalogue-main catalogue && cd /home/roboshop/catalogue && npm install &>>$LOG &&
chown roboshop:roboshop /home/roboshop -R
Stat $?

Head "Update Endpoints in Service file"
sed -i -e "s/MONGO_DNSNAME/mongodb.kavya.website/" /home/roboshop/catalouge/systemd.service
Stat $?

Head"Setup systemd Service"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service

Head " Restart the service"
systemctl daemon-reload
&& systemctl start catalogue && systemctl enable catalogue
Stat $?

