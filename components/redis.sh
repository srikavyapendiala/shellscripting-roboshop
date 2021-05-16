#!/bin/bash

source components/common.sh
OS_PREREQ

Head"Install redis Server"
apt install redis-server &>>$LOG
Stat $?

Head" "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
Stat $?

Head"Start Redis Server"
systemctl restart redis
Stat $?
