count=1
for n in $(seq 1 10)
do
echo -ne "$n $count\r"
sleep 2s
count=`expr $count + 1`
done
