#!/bin/bash

source components/common.sh

OS_PREREQ
 Head "Install Nginx"
 apt install nginx -y &>>$LOG
 Stat $?

 Head "Start Nginx Service"
 systemctl start nginx
 Stat $?

 DOWNLOAD_COMPONENT

 Head "Remove Default Configuration"
 rm -rf /var/www/html /etc/nginx/sites_enabled/default /etc/nginx/sites-available/default
 Stat $?

 Head "Unzip Downloaded archieve"
 cd /var/www
 && unzip /tmp/frontend.zip &>>$LOG
 && mv frontend-main/* .
 && mv static html
 && rm -rf frontend-main README.md
 Stat $?

 Head "Update Nginx Configuration"
 mv roboshop.conf /etc/nginx/sites-enabled//roboshop.conf
 Stat $?

 Head "Start Nginx Service"
 systemctl restart nginx
 Stat $?

