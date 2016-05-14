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
        echo "Usage: sh 99_run_experiments.sh <experiment code0> [experiment code1]..." 
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
script=${work}/${dir_sh}/01_run_experiments.sh
rm -rf $script && touch $script && chmod 751 $script

#write info into script
code_num=$#
sh_prefix=${work}/${dir_sh}
sh_suffix="_start.sh"

#write each job into script
for i in $(seq 1 ${code_num})
do
	eval code=\$$i
	job=${sh_prefix}/${code}${sh_suffix}
        echo -e "\n#experiment $code" >> $script
	echo "echo \"experiment $code start analysis!\"" >> $script
        echo "nohup sh $job >> $log 2>&1 &" >> $script
        echo "echo \$! >> $pids" >> $script
done

#echo check job status into script
echo -e "\n#check above job status, exit when all jobs are complete" >> $script
duration=${sleep_time}
echo "sh ${work}/${dir_tool}/${sh_update} $pids ${duration}" >> $script

#echo complete info
echo ">>>>>Script generated at: $script"
