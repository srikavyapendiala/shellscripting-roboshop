#!/bin/bash
source components/common.sh
OS_PREREQ

Head"Download Docker File"
curl -s https://get.docker.com | bash
Stat $?

Head"Enable and start Docker"
systemctl enable docker && systemctl start docker
Stat $?

Head "Start MySQL with docker"
mkdir -p /data
docker ps | grep mysql -i &>>$LOG
if [ $? -ne 0]; then
  docker run -v /data:/var/lib/mysql -p 3306:3306 -d -e MYSQL_ROOT_PASSWORD=password mysql:5.7.33 &>>$LOG
if
Stat $?

DOWNLOAD_COMPONENT

Head "Extract Downloaded Schema"
cd /tmp && unzip /tmp/mysql.zip &>>$LOG
Stat $?

Head"Install MYSQL Client"
apt install maradb-client-core -y &>>$LOG

Head "Load Schema "
cd mysql-main
IPADDR=$(hostname -i)
mysql -h <IP-ADDRESS> -uroot -ppassword <shipping.sql &>>$LOG
Stat $?
