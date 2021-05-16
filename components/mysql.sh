#!/bin/bash
Head"Download Docker File"
curl -s https://get.docker.com | bash
Stat $?
Head"Enable and start Docker"
systemctl enable docker && systemctl start docker
Stat $?

Head "Start MySQL Container and also should be accessible over network"
mkdir /data
docker run -v /data:/var/lib/mysql -p 3306:3306 -d -e MYSQL_ROOT_PASSWORD=password mysql:5.7.33
Stat $?

DOWNLOAD_COMPONENT

Head " switch to directory and unzip"
cd /tmp && unzip /tmp/mysql.zip && cd mysql-main && mysql -h <IP-ADDRESS> -uroot -ppassword <shipping.sql