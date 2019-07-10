#!/bin/bash
if [ $# -lt 1 ];then
  echo "must pass arg : acc1, acc2"
  exit 1
fi

case $1 in
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

SECRET_DIR="./secret"
KEY_FILE=$SECRET_DIR"/$ROLE.key"

if [ ! -f "$KEY_FILE" ]; then
    echo "$KEY_FILE not exist"
    exit 1
fi

PRIVATE_KEY=`awk '/Private/{print $3}' $KEY_FILE`
PUBLIC_KEY=`awk '/Public/{print $3}' $KEY_FILE`

cleos system newaccount eosio --transfer $ROLE \
$PUBLIC_KEY \
--stake-net "100000.0000 SYS" \
--stake-cpu "100000.0000 SYS" \
--buy-ram-kbytes 8192