#!/bin/bash

function issue(){
cleos system newaccount eosio --transfer \
      $1 $2 \
      --stake-net "100000000.0000 TYM" \
      --stake-cpu "100000000.0000 TYM" \
      --buy-ram-kbytes 8192
}

ROOT="./nodes"
checkdir $ROOT
SECRET_DIR="$ROOT/secret"
BP_ACC=(\
  accountnum11 \
  accountnum22 \
  accountnum33 \ 
)

for ACC in ${BP_ACC[*]}
do
  echo $ACC
  ACC_KEY_FILE="$SECRET_DIR/$ACC.key"
  ACC_PUBLIC_KEY=`awk '/Public/{print $3}' $ACC_KEY_FILE`
  issue $ACC $ACC_PUBLIC_KEY

done


