#!/bin/bash

COMPONENT =$1
if[ ! -f components/${COMPONENT}.sh ] ; then
  ERROR "Invalid file"
  exit 1
fi

USER_NAME=$(whoami)

if [ "${USER_NAME}" != "root" ]; then
    ERROR "you should be a root user to try this script, Try with sudo"
    exit 1
fi

export COMPONENT
bash -x components/${COMPONENT}.sh