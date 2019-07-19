#!/bin/bash

ROOT="$(pwd)/nodes"
PID_DIR="$ROOT/pid"
WALLET_DIR="$ROOT/wallet"
LOG_DIR="$ROOT/log"

APP="keosd"

function checkdir() {
  if [ ! -d $1 ]; then
    mkdir -p $1
  fi
}

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

checkdir $PID_DIR
checkdir $WALLET_DIR
checkdir $LOG_DIR

keosd \
  --http-server-address 0.0.0.0:9900 \
  --wallet-dir $WALLET_DIR \
  --http-validate-host false \
  >>$LOG_DIR"/$APP.log" 2>&1 &
echo $! >$PID_DIR"/$APP.pid"

echo 'keosd started' $(cat $PID_DIR/$APP.pid)



