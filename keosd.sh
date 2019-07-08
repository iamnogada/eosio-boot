#!/bin/bash
ROLE="keosd"
LOG_DIR="./log"

if [ ! -d $LOG_DIR ]; then
  mkdir -p $LOG_DIR;
fi

keosd --http-server-address 0.0.0.0:9900 \
--http-validate-host false \
>> $LOG_DIR"/$ROLE.log" 2>&1 & \
echo $! > $LOG_DIR"/$ROLE.pid"
