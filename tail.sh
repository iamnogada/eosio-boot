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
    PEER2=0.0.0.0:9013
    ;;
  acc1)
    ROLE="accountnum11"
    HTTP=0.0.0.0:8801
    P2P_LISTEN=0.0.0.0:9011
    PEER1=0.0.0.0:9010
    PEER2=0.0.0.0:9012
    PEER2=0.0.0.0:9013
    ;;
  acc2)
    ROLE="accountnum22"
    HTTP=0.0.0.0:8802
    P2P_LISTEN=0.0.0.0:9012
    PEER1=0.0.0.0:9010
    PEER2=0.0.0.0:9011
    PEER2=0.0.0.0:9013
    ;;
  acc3)
    ROLE="accountnum33"
    HTTP=0.0.0.0:8802
    P2P_LISTEN=0.0.0.0:9013
    PEER1=0.0.0.0:9010
    PEER2=0.0.0.0:9011
    PEER2=0.0.0.0:9012
    ;;
  *)
    echo "must pass arg : eosio, acc1, acc2"
    exit 1
esac

ROOT="./nodes"
DATADIR="$ROOT/$ROLE"
SECRET_DIR="$ROOT/secret"
LOG_DIR="$ROOT/log"
PID_DIR="$ROOT/pid"


tail -f "$LOG_DIR/$ROLE.log" -n 100