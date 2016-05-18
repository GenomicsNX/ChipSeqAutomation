#!/bin/bash
#title  98_run_complex.sh
#author j1angvei
#date   20160517
#usage  run all complex experiment relevant scripts(macs, homer, go, pathway...)
#==========================================================================================

#init parameter
work=`pwd`

#test if parameter was correct 
if [ $# -lt 1 ]
then
	echo "Usage: sh 98_run_single.sh <experiment code0> [experiment code1] ... "
	exit
fi
#import config
source config/directory.conf
source config/executable.conf
source config/preference.conf

#create files to store pids and logs
pids=${work}/${dir_pid}/02_run_complexes.pids
log=${work}/${dir_log}/02_run_complexes.log
rm -rf  $pids $log && touch $pids $log

#build script to run genome relevant job
script=${work}/${dir_sh}/02_run_complexes.sh
rm -rf $script && touch $script && chmod 751 $script

#write info into script
code_num=$#
sh_prefix=${work}/${dir_sh}
sh_suffix="_complex.sh"
#write each job into script\
for i in $(seq 1 $code_num)
do
	eval code=\${$i}
	job=${sh_prefix}/${code}${sh_suffix}
	
	#if current experiment is a control experiment, skip it
	if [ ! -e $job ]; then
		echo -e "\n# ${code} is control experiment, no complex operation " >> $script
		continue
	fi
	echo -e "\n#experiment $code" >> $script
	echo "echo \"experiment $code start analysis!\"" >> $script
	echo "nohup sh ${job} >> $log 2>&1 &" >> $script
	echo "echo \$! >> $pids" >> $script
done

#echo check job status into script
echo -e "\n#check above job status, exit when all jobs are complete!" >> $script
duration=${sleep_time}
echo "sh ${work}/${dir_tool}/${sh_update} $pids ${duration}" >> $script

#echo complete info
echo ">>>>>Script generated at: $script"
