#!/bin/bash

source components/common.sh

OS_PREREQ
 Head "Install Nginx"
 apt install nginx -y &>>$LOG
 STAT $?

 Head "Start Nginx Service"
 systemctl start nginx
 STAT $?

 DOWNLOAD_COMPONENT

 Head "Remove Default Configuration"
 rm -rf /var/www/html /etc/nginx/sites_enabled/default /etc/nginx/sites-available/default
 STAT $?

 Head "Unzip Downloaded archieve"
 cd /var/www
 && unzip /tmp/frontend.zip &>>$LOG
 && mv frontend-main/* .
 && mv static html
 && rm -rf frontend-main README.md
 STAT $?

 Head "Update Nginx Configuration"
 mv roboshop.conf /etc/nginx/sites-enabled//roboshop.conf
 STAT $?

 Head "Start Nginx Service"
 systemctl restart nginx
 STAT $?

