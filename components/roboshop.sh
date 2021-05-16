#!/bin/bash

export LOG=tmp/${COMPONENT}.log
rf -rf $LOG

COMPONENT =$1

if [! -f components/${COMPONENT}.sh ]; then
   echo -e "\e[31m "Invalid file\e[0m"
   exit 1
fi

USER_NAME=$(Whoami)

if [ "${USER_NAME}" != "root" ]; then
    error "you should be a root user to try this script, Try with sudo"
    exit 1
fi

export COMPONENT
bash -x components/${COMPONENT}.sh
