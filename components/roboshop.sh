#!/bin/bash

COMPONENT =$1
if[ ! -f components/${COMPONENT}.sh ] ; then
  echo "Invalid file"
  exit 1
fi

bash components/${COMPONENT}.sh