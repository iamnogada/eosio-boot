#!/bin/bash
SECRET_DIR=\"./secret\"

if [ ! -d $SECRET_DIR ]; then
  mkdir -p $SECRET_DIR;
fi
PASSWORD_FILE=$SECRET_DIR\"/pin\"
echo "Creating default wallet's password"

cleos wallet create -f $PASSWORD_FILE
EOSIO_PASSWORD=`cat $PASSWORD_FILE`

echo \"password is $EOSIO_PASSWORD\"

echo \"Create genesis key\"
GENESIS_KEY_FILE=$SECRET_DIR\"/main.key\"
cleos wallet unlock --password $EOSIO_PASSWORD
cleos create key -f $GENESIS_KEY_FILE

GENESIS_PRIVATE_KEY= `awk '/Private/{print $3}' $GENESIS_KEY_FILE`
GENESIS_PUBLIC = `awk '/Public/{print $3}' $GENESIS_KEY_FILE`

cat << EOF > genesis.json
{
    "initial_timestamp": "2018-12-05T08:55:11.000",
    "initial_key": "$GENESIS_PUBLIC",
    "initial_configuration": {
      "max_block_net_usage": 1048576,
      "target_block_net_usage_pct": 1000,
      "max_transaction_net_usage": 524288,
      "base_per_transaction_net_usage": 12,
      "net_usage_leeway": 500,
      "context_free_discount_net_usage_num": 20,
      "context_free_discount_net_usage_den": 100,
      "max_block_cpu_usage": 100000,
      "target_block_cpu_usage_pct": 500,
      "max_transaction_cpu_usage": 50000,
      "min_transaction_cpu_usage": 100,
      "max_transaction_lifetime": 3600,
      "deferred_trx_expiration_window": 600,
      "max_transaction_delay": 3888000,
      "max_inline_action_size": 4096,
      "max_inline_action_depth": 4,
      "max_authority_depth": 6
    },
    "initial_chain_id": "0000000000000000000000000000000000000000000000000000000000000000"
  }
EOF