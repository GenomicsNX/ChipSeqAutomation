#!/bin/bash
#title  update_pids.sh
#author j1angvei
#date   20160504
#usage  check job status, if a job is done, delete the pid from file, exit when all jobs are done.
#==========================================================================================

#function to update job pids if still running
function update(){

	#receive passing parameters
	pids=$1
	sleep_time=$2
	count=$3
	
	#statistic how many jobs still running
	num=`cat $pids | wc -l`
	
	#echo job status and job statistic to stout
	all_pids=`grep -v '^$' $pids | tr '\n' ',' `
	echo -ne "---Check Times:$count;---Job Numbers:${num};---Job Pids:${all_pids%,*};---Check Again:${sleep_time}.\r"
	
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
	echo "Usage: sh update_pids.sh [pids file] [sleep time]"
	exit
fi

#flag to check if all jobs are done
prev=0

#mark times check the job status and output to stout
count=1

#start loop to check status, only all job is done, exit the loop
until [ $prev -eq 1 ]
do
	#check all job status in pid files
	update "${1}" "${2}" "$count"
	
	#$? represents result of last running script.
	prev=$?
	
	#increase check times
	count=`expr $count + 1`
	
	#sleep current thread for ${duration}
	sleep "$2"
done

#output complete information
echo -e "<<<<<all ${word} jobs in ${pid_file} are done!\n"
