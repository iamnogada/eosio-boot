#!/bin/bash
SECRET_DIR="./secret"

if [ ! -d $SECRET_DIR ]; then
  mkdir -p $SECRET_DIR;
fi

echo "Creating default wallet's password"
cleos wallet create -f $SECRET_DIR/pin
EOSIO_PASSWORD=`cat $SECRET_DIR/pin`

echo "password is $EOSIO_PASSWORD"

echo "Create genesis key"
cleos wallet unlock --password $EOSIO_PASSWORD
cleos create key -f $SECRET_DIR/eosio.key


