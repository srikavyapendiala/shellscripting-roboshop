#!/bin/bash

Heading() {
  echo -e "\e[1;36m =================$1===============\e[0m"
  echo -e "\e[1;36m =================$1===============\e[0m" &>>$LOG
}

Stat() {
  if [ "$1" -eq 0]; then
    echo -e "\e[1;32m" SUCCESS\e[0m"
  else
    echo -e "\e[1;31m" FAILURE\e[0m"
    echo -e "\n\e[1;33m" we can refer log file log file path, log file path = ${LOG}\e[0m"
  fi

OS_PREREQ() {
  set-hostname ${component}
  Head "Updating APT repos"
  apt update &>>$LOG
}

ERROR() {
  echo -e "\e[1;31m$1\e[0m"
}

DOWNLOAD_COMPONENT() {
  Head "Downloading ${COMPONENT} component"
  curl -s -L -o /tmp/${COMPONENT}.zip/ "https://github.com/srikavyapendiala/shellscripting-roboshop/${COMPONENT}
  /archieve/main.zip"
}
