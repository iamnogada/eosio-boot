# eosio-boot
> 2019.07 현재 1.7 버전이 eosio.contract와 호환되어 1.7 기준으로 작성함.




### 사전 준비
- ubuntu 18.04
- eosio 1.7.4 설치
- eosio.cdt 1.6.2 설치
- eosio.contract v1.6.0 : git clone https://github.com/EOSIO/eosio.contracts.git
- checkout v1.6.0 : git checkout tags/v1.6.0
- 주의) 빌드를 위해 여러 tool 설치가 필요 할 수 있음 예) CMake, CLang 등

## Step 01: 지갑 서비스 시작
- cmd: ./keosd.sh
- http-server-address : use 0.0.0.0 for access from outside
- http-validate-host =  false (특정 서버에서 접근이 필요한 경우)

``` shell
keosd \
  --http-server-address 0.0.0.0:9900 \
  --wallet-dir $WALLET_DIR
  --http-validate-host false \
  >>$LOG_DIR"/$APP.log" 2>&1 &
 echo $! >$PID_DIR"/$APP.pid"
```

## Step 02: Create Default wallet
- cmd : cleos create wallet -f ${password file}
- 지갑이 열려있는지 확인: default 명 뒤에 * 표시 확인
- cleos wallet list
``` json
[
  "default *"
]
```

## Step 03: Key Register
> Public/Private Key를 생성하고 지갑 서비스에 등록
> node 최초 실행을 위한 genesis.json 생성
> key : root, accountnum11, accountnum22, accountnum33 용으로 4개 생성
> key path : ./nodes/secret
> 
- cmd: ./genkey.sh
- out(./nodes/secret): eosio.key, accountnum11.key, accountnum22.key, accountnum33.key
- out(./nodes): genesis.json

## Step 04: Init genesis node
> genesis.json 파일을 이용한 최초 노드 생성
> cmd: ./init.sh eosio
> 실행 확인 : ./tail.sh eosio

```
info  2019-07-26T07:57:06.000 thread-0  producer_plugin.cpp:1597      produce_block        ] Produced block 000000138efd8b5b... #19 @ 2019-07-26T07:57:06.000 signed by eosio [trxs: 0, lib: 18, confirmed: 0]
```

## Step 05: Create system accounts
> account 
* eosio.bpay 
* eosio.msig 
* eosio.names 
* eosio.ram 
* eosio.ramfee 
* eosio.saving 
* eosio.stake 
* eosio.token 
* eosio.vpay 
* eosio.rex 

> cmd : ./sysacc.sh