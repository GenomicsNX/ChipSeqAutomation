#!/bin/bash
#title  update_pids.sh
#author j1angvei
#date   20160504
#usage  check job status, if a job is done, delete the pid from file, exit when all jobs are done.
#==========================================================================================

#function to update job pids if still running
function update(){
	#receive pids file
	pids=$1
	
	#statistic how many jobs still running
	count=`wc -l $pids`
	count=${count% *}
	if [ "$count" -eq 1 ]
	then
		echo -e "$count job still in progress"
	else
		echo -e "$count jobs still in progress"
	fi
	
	#create bak file of pid file to store running jobs' pid after checking status
	bak=${pids}.bak
	rm -rf $bak && touch $bak

	#read pid one by one and check its status
	for pid in `cat $pids`
	do
		status=`ps -p $pid | wc -l`
		if [ "$status" -eq 2 ]
		then 
			echo "$pid" >> $bak
			echo "$pid"
		fi
	done

	#replace pids file content with bak file, which has delete complete job's pid
	cat $bak > $pids
	
	#return result, judging from if pids file is empty
	if [ -s $pids ]
	then 
		#file is not empty, jobs still running
		return 0
	else 
		#pids file is empty, all jobs are done.
		rm -rf $bak
		return 1
	fi
	
}
#check passing arguments
if [ $# -lt 3 ]
then
	echo "Usage: sh update_pids.sh [pids file] [job description (ONE word)] [sleep time]"
	exit
fi

#accpet passing arguments
pid_file=$1
word=$2
duration=$3

#flag to check if all jobs are done
prev=0

#start loop to check status, only all job is done, exit the loop
until [ $prev -eq 1 ]
do
	update ${pid_file}
	prev=$?
	echo "check job status of ${word} ${duration} later"
	sleep $duration
done

#output complete information
echo -e "all ${word} jobs in ${pid_file} are done!\n"
