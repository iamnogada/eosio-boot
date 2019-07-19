#!/bin/bash
if [ $# -lt 1 ];then
  echo "must pass arg : eosio, acc1, acc2"
  exit 1
fi

case $1 in
  eosio)
    ROLE=$1
    ;;
  acc1)
    ROLE="bproducer111"
    ;;
  acc2)
    ROLE="bproducer222"
    ;;
  *)
    echo "must pass arg : eosio, acc1, acc2"
    exit 1
esac

LOG_DIR="./log"
LOG_FILE=$LOG_DIR"/$ROLE.log"


tail -f $LOG_FILE