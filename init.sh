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
    ROLE=$1
    ;;
  acc2)
    ROLE=$1
    ;;
  *)
    echo "must pass arg : eosio, acc1, acc2"
    exit 1
esac

DATADIR="./$ROLE"
SECRET_DIR="./secret"
KEY_FILE=$SECRET_DIR"/$ROLE.key"
LOG_DIR="./log"
LOG_FILE=$LOG_DIR"/$ROLE.log"

if [ ! -d $DATADIR ]; then
  mkdir -p $DATADIR;
fi
if [ ! -d $LOG_DIR ]; then
  mkdir -p $LOG_DIR;
fi

if [ ! -f "$KEY_FILE" ]; then
    echo "$KEY_FILE not exist"
    exit 1
fi

PRIVATE_KEY=`awk '/Private/{print $3}' $KEY_FILE`
PUBLIC_KEY=`awk '/Public/{print $3}' $KEY_FILE`

nodeos \
--genesis-json "./genesis.json" \
--signature-provider $PUBLIC_KEY=KEY:$PRIVATE_KEY \
--plugin eosio::producer_plugin \
--plugin eosio::chain_api_plugin \
--plugin eosio::http_plugin \
--plugin eosio::history_api_plugin \
--plugin eosio::history_plugin \
--data-dir $DATADIR"/data" \
--blocks-dir $DATADIR"/blocks" \
--config-dir $DATADIR"/config" \
--producer-name $ROLE \
--http-server-address 127.0.0.1:8888 \
--p2p-listen-endpoint 127.0.0.1:9010 \
--access-control-allow-origin=* \
--contracts-console \
--http-validate-host=false \
--verbose-http-errors \
--enable-stale-production \
>> $LOG_DIR"/$ROLE.log" 2>&1 & \
echo $! > $DATADIR"/$ROLE.pid"