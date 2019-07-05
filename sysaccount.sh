#!/bin/bash

function genKey(){
  ACC_KEY_FILE=$1
  cleos create key -f $ACC_KEY_FILE


  ACC_PRIVATE_KEY=`awk '/Private/{print $3}' $ACC_KEY_FILE`
  ACC_PUBLIC_KEY=`awk '/Public/{print $3}' $ACC_KEY_FILE`

  cleos wallet import --private-key $ACC_PRIVATE_KEY
}
ACC_KEY_FILE="./secret/system.key"

genKey $ACC_KEY_FILE
ACC_PUBLIC_KEY=`awk '/Public/{print $3}' $ACC_KEY_FILE`

cleos create account eosio eosio.bpay $ACC_PUBLIC_KEY
cleos create account eosio eosio.msig $ACC_PUBLIC_KEY
cleos create account eosio eosio.names $ACC_PUBLIC_KEY
cleos create account eosio eosio.ram $ACC_PUBLIC_KEY
cleos create account eosio eosio.ramfee $ACC_PUBLIC_KEY
cleos create account eosio eosio.saving $ACC_PUBLIC_KEY
cleos create account eosio eosio.stake $ACC_PUBLIC_KEY
cleos create account eosio eosio.token $ACC_PUBLIC_KEY
cleos create account eosio eosio.vpay $ACC_PUBLIC_KEY
cleos create account eosio eosio.rex $ACC_PUBLIC_KEY

