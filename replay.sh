#!/bin/bash
if [ $# -lt 1 ];then
  echo "must pass arg : eosio, acc1, acc2"
  exit 1
fi

case $1 in
  eosio)
    ROLE=$1
    HTTP=0.0.0.0:8888
    P2P_LISTEN=0.0.0.0:9010
    PEER1=0.0.0.0:9011
    PEER2=0.0.0.0:9012
    PEER3=0.0.0.0:9013
    ;;
  acc1)
    ROLE="accountnum11"
    HTTP=0.0.0.0:8801
    P2P_LISTEN=0.0.0.0:9011
    PEER1=0.0.0.0:9010
    PEER2=0.0.0.0:9012
    PEER3=0.0.0.0:9013
    ;;
  acc2)
    ROLE="accountnum22"
    HTTP=0.0.0.0:8802
    P2P_LISTEN=0.0.0.0:9012
    PEER1=0.0.0.0:9010
    PEER2=0.0.0.0:9011
    PEER3=0.0.0.0:9013
    ;;
  acc3)
    ROLE="accountnum33"
    HTTP=0.0.0.0:8803
    P2P_LISTEN=0.0.0.0:9013
    PEER1=0.0.0.0:9010
    PEER2=0.0.0.0:9011
    PEER3=0.0.0.0:9012
    ;;
  *)
    echo "must pass arg : eosio, acc1, acc2"
    exit 1
esac



function checkdir() {
  if [ ! -d $1 ]; then
    mkdir -p $1
  fi
}

ROOT="./nodes"
DATADIR="$ROOT/$ROLE"
SECRET_DIR="$ROOT/secret"
LOG_DIR="$ROOT/log"
PID_DIR="$ROOT/pid"

checkdir $DATADIR
checkdir $LOG_DIR
checkdir $PID_DIR

KEY_FILE=$SECRET_DIR"/$ROLE.key"
if [ ! -f "$KEY_FILE" ]; then
    echo "$KEY_FILE not exist"
    exit 1
fi

PRIVATE_KEY=`awk '/Private/{print $3}' $KEY_FILE`
PUBLIC_KEY=`awk '/Public/{print $3}' $KEY_FILE`

nodeos \
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
--http-server-address $HTTP \
--p2p-listen-endpoint $P2P_LISTEN \
--access-control-allow-origin=* \
--contracts-console \
--http-validate-host=false \
--verbose-http-errors \
--enable-stale-production \
--p2p-peer-address $PEER1 \
--p2p-peer-address $PEER2 \
--p2p-peer-address $PEER3 \
--hard-replay-blockchain \
>> $LOG_DIR"/$ROLE.log" 2>&1 & \
echo $! >$PID_DIR"/$ROLE.pid"


