#!/bin/bash

Install RabbtiMQ
# apt update
# curl -fsSL https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc | apt-key add -
# apt install apt-transport-https -y
# echo -e "deb https://dl.bintray.com/rabbitmq-erlang/debian focal erlang\ndeb https://dl.bintray.com/rabbitmq/debian bionic main" > /etc/apt/sources.list.d/bintray.rabbitmq.list
# apt update -y
# apt install rabbitmq-server -y --fix-missing
RabbitMQ comes with a default username / password as guest/guest. But this user cannot be used to connect. Hence we need to create one user for the application.

Create application user
# rabbitmqctl add_user roboshop roboshop123
# rabbitmqctl set_user_tags roboshop administrator
# rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

