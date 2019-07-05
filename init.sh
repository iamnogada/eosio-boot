#!/bin/bash
SECRET_DIR="./secret"

if [ ! -d $DATADIR ]; then
  mkdir -p $DATADIR;
fi

echo "Creating default wallet's password"
cleos wallet create -f $SECRET_DIR/pin
EOSIO_PASSWORD=`cat $SECRET_DIR/pin`

echo "password is $EOSIO_PASSWORD"

