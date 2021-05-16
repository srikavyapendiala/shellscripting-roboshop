#!/bin/bash
Install Maven, This will install Java too
# apt update
# apt install maven -y
As per the standard process, we always run the applications as a normal user.
Create a user

# useradd -m -s /bin/bash roboshop
Download the repo
$ cd /home/roboshop
$ curl -s -L -o /tmp/shipping.zip "https://github.com/zelar-soft-roboshop/shipping/archive/main.zip"
$ unzip /tmp/shipping.zip
$ mv shipping-main shipping
$ cd shipping
$ mvn clean package
$ mv target/shipping-1.0.jar shipping.jar
Copy the service file and start the service.
# mv /home/roboshop/shipping/systemd.service /etc/systemd/system/shipping.service
# systemctl daemon-reload
# systemctl start shipping
# systemctl enable shipping

