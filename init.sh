#!/bin/bash

echo "Creating default wallet's password"
cleos wallet create -f ./secret/pin
EOSIO_PASSWORD=`cat ./secret/pin`

echo "password is $EOSIO_PASSWORD"

