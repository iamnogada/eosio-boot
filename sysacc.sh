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

# cleos set contract eosio.token $EOSIO_CONTRACTS_DIRECTORY/eosio.token/
# cleos set contract eosio.msig $EOSIO_CONTRACTS_DIRECTORY/eosio.msig/
# cleos push action eosio.token create '[ "eosio", "10000000000.0000 SYS" ]' -p eosio.token@active
# cleos push action eosio.token issue '[ "eosio", "1000000000.0000 SYS", "memo" ]' -p eosio@active
# cleos set contract eosio $EOSIO_CONTRACTS_DIRECTORY/eosio.system/
# cleos push action eosio setpriv '["eosio.msig", 1]' -p eosio@active
# cleos push action eosio init '["0", "4,SYS"]' -p eosio@active

