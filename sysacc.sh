#!/bin/bash


function addKey(){
  ACC_KEY_FILE="$SECRET_DIR/$1"
  cleos create key -f $ACC_KEY_FILE


  ACC_PRIVATE_KEY=`awk '/Private/{print $3}' $ACC_KEY_FILE`
  ACC_PUBLIC_KEY=`awk '/Public/{print $3}' $ACC_KEY_FILE`

  cleos wallet import --private-key $ACC_PRIVATE_KEY
  cleos create account eosio $1 $ACC_PUBLIC_KEY

}
function checkdir() {
  if [ ! -d $1 ]; then
    mkdir -p $1
  fi
}
ROOT="./nodes"
checkdir $ROOT
SECRET_DIR="$ROOT/secret"
checkdir $SECRET_DIR

EOS_ACC=(\
  eosio.bpay \
  eosio.msig \
  eosio.names \
  eosio.ram \
  eosio.ramfee \
  eosio.saving \
  eosio.stake \
  eosio.token \
  eosio.vpay \
  eosio.rex \
)

for ACC in ${EOS_ACC[*]}
do
  echo $ACC
  addKey $ACC

done