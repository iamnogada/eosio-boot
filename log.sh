#!/bin/bash
if [ $# -lt 1 ];then
  echo "must pass arg : main, acc1, acc2"
  exit 1
fi

case $1 in
  main)
    ROLE=$1
    ;;
  acc1)
    ROLE=$1
    ;;
  acc2)
    ROLE=$1
    ;;
  *)
    echo "must pass arg : main, acc1, acc2"
    exit 1
esac

LOG_DIR="./log"
LOG_FILE=$LOG_DIR"/$ROLE.log"


tail -f $LOG_FILE