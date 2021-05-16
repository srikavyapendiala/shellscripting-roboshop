#!/bin/bash
source components/common.sh
OS_PREREQ

Head "Install RabbtiMQ"
curl -fsSL https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc | apt-key add -
apt install apt-transport-https -y &>>$LOG && echo -e "deb https://dl.bintray.com/rabbitmq-erlang/debian focal erlang\ndeb https://dl.bintray.com/rabbitmq/debian bionic main" > /etc/apt/sources.list.d/bintray.rabbitmq.list
Stat $?

Head "Update all Dependencies"
apt update -y
apt install rabbitmq-server -y --fix-missing

Head "create one user for the application"
rabbitmqctl add_user roboshop roboshop123 && rabbitmqctl set_user_tags roboshop administrator
&& rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

