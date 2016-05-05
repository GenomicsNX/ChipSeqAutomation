#!/bin/bash
#title  update_pids.sh
#author j1angvei
#date   20160504
#usage  check job status, if job is done, delete job pid from file
#==========================================================================================

#function to update job pids if still running
function update(){
	pids=$1
	bak=${pids}.bak
	rm -rf $bak && touch $bak

	echo "$pids $bak"
	#read pid one by one and check its status
	for pid in `cat $pids`
	do
		echo $pid
		status=`ps -p $pid | wc -l`
		if [ "$status" -eq 2 ]
		then 
			echo $pid >> $bak
		fi
	done

	#replace still running job pids wiht previous job pids
	cat $bak > $pids
	
	#return result, judging from if pids file is empty
	if [ -s $pids ]
	then 
		#file is not empty, jobs still running
		return 0
	else 
		#pids file is empty, all jobs are done.
		return 1
	fi
	
}
#check passing arguments
if [ $# -lt 1 ]
then
	echo "Usage: sh update_pids.sh [pids file]"
	exit
fi

pid_file=$1
prev=0
echo "start until loop"
until [ $prev -eq 1 ]
do
	update ${pid_file}
	prev=$?
	echo "sleep 5 seconds"
	sleep 5s
done

echo "all job in ${pid_file} are done!"
