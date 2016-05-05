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
	echo -e "$count job(s) still running"
	
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
if [ $# -lt 2 ]
then
	echo "Usage: sh update_pids.sh [pids file] [job description (ONE word)]"
	exit
fi

#accpet passing arguments
pid_file=$1
word=$2

#flag to check if all jobs are done
prev=0

#start loop to check status, only all job is done, exit the loop
until [ $prev -eq 1 ]
do
	update ${pid_file}
	prev=$?
	echo "check job status of ${word} 30 seconds later"
	sleep 30s
done

#output complete information
echo -e "all ${word} jobs in ${pid_file} are done!\n"
