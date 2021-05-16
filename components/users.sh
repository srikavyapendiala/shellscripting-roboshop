#!/bin/bash
source components/common.sh
OS_PREREQ

Head "Install Nginx"
apt install npm -y &>>$LOG

Head "Adding roboshop to user"
if [$? -ne o]; then
   useradd -m -s /bin/bash roboshop
   Stat $?
fi

DOWNLOAD_COMPONENT

Head "switch to the roboshop user and run the following commands"
cd /home/roboshop && unzip /tmp/user.zip &>>$LOG && mv user-main user && cd /home/roboshop/user && npm install &>>$LOG &&
   chown roboshop:roboshop /home/roboshop -R
Stat $?

Head "Update EndPoints In Service File"
sed -i -e "s/MONGO_DNSNAME/mongodb.kavya.website/" -e "s/REDIS_ENDPOINT/redis.kavya.website/" -e "s/MONGO_ENDPOINT/mogodb.kavya.website/"  /home/roboshop/user/systemd.service
Stat $?

Head "update the IP address of MONGODB Server in systemd.service file"
mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service

Head "set up the service with systemctl"
systemctl daemon-reload && systemctl start user
&& systemctl enable user

