#!/bin/bash
#title  99_run_experiments.sh
#author j1angvei
#date   20160511
#usage  run all experiment relevant scripts(qc, trim, alignment, peak calling etc.)
#==========================================================================================
#init parmeter
work=`pwd`

#test if parameter was correct 
if [ $# -lt 1 ]
then
        echo "Usage: sh 99_run_experiments.sh [job scripts] "
        exit
fi
#import config
source config/directory.conf
source config/executable.conf
source config/preference.conf

#create files to store pids and logs
pids=${work}/${dir_pid}/run_experiments.pids
log=${work}/${dir_log}/run_experiments.log
rm -rf  $pids $log && touch $pids $log

#build script to run genome relevant job
script=${work}/${dir_sh}/run_experiments.sh
rm -rf $script && touch $script && chmod 751 $script

#write info into script
all_jobs=$1

#write each job into script
for s in ${all_jobs}
do
        echo "# job $s" >> $script
	echo "echo \"job $s start running!\"" >> $script
        echo "nohup sh $s >> $log 2>&1 &" >> $script
        echo -e "echo \$! >> $pids \n" >> $script
done

#echo check job status into script
echo "#check above job status, exit when all jobs are complete" >> $script
duration=${sleep_time}
echo "sh ${work}/${dir_tool}/${sh_update} $pids ${duration}" >> $script

#echo complete info
echo -e "======Script generated at $script \n"

