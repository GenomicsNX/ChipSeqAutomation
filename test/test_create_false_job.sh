if [ -s test.pids ]
then 
	rm -rf test.pids && touch test.pids
fi

for n in `seq 1 6 66`
do
nohup sleep $n >test.log 2>&1 &
echo $! >> test.pids
done
