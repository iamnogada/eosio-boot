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
    ROLE="accountnum11"
    ;;
  acc2)
    ROLE="accountnum22"
    ;;
  acc3)
    ROLE="accountnum33"
    HTTP=0.0.0.0:8802
    ;;
  *)
    echo "must pass arg : eosio, acc1, acc2"
    exit 1
esac

ROOT="./nodes"
DATADIR="$ROOT/$ROLE"
PID_DIR="$ROOT/pid"

APP=$ROLE
if [ -f "$PID_DIR/$APP.pid" ]; then
  pid=$(cat $PID_DIR/$APP.pid)
  echo $pid
  kill $pid

  echo -ne "Stoping $APP"
  while true; do
    [ ! -d "/proc/$pid/fd" ] && break
    echo -ne "."
    sleep 1
    rm -r $PID_DIR"/$ROLE.pid"
  done
  echo -ne "\n$APP Stopped. \n"
fi

