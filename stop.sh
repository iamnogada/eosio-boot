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
    ROLE="bproducer001"
    ;;
  acc2)
    ROLE="bproducer002"
    ;;
  *)
    echo "must pass arg : eosio, acc1, acc2"
    exit 1
esac

echo $ROLE

DATADIR="./$ROLE"

if [ -f $DATADIR"/$ROLE.pid" ]; then
pid=`cat $DATADIR"/$ROLE.pid"`
echo $pid
kill $pid

echo -ne "Stoping $ROLE"
while true; do
[ ! -d "/proc/$pid/fd" ] && break
echo -ne "."
sleep 1
rm -r $DATADIR"/$ROLE.pid"
done
echo -ne "\n$ROLE Stopped. \n"
fi