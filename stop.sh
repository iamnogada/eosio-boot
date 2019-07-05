if [ $# -lt 1 ];then
  echo "must pass arg : main, acc1, acc2"
  exit 1
fi

case $1 in
  main)
    ROLE=$1
    ;;
  acc1)
    ROLE=$1
    ;;
  acc2)
    ROLE=$1
    ;;
  *)
    echo "must pass arg : main, acc1, acc2"
    exit 1
esac

echo $ROLE

DATADIR="./$ROLE"
LOG_DIR=$DATADIR"/log"

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