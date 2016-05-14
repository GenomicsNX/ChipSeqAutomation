#!/bin/bash
#title  98_run_genome.sh
#author j1angvei
#date   20160504
#usage  run all genome relevant scripts(build genome idx, etc.)
#==========================================================================================

#init parameter
work=`pwd`

#test if parameter was correct 
if [ $# -lt 1 ]
then
	echo "Usage: sh 98_run_genome.sh <genome code0> [genome code1] ... "
	exit
fi
#import config
source config/directory.conf
source config/executable.conf
source config/preference.conf

#create files to store pids and logs
pids=${work}/${dir_pid}/run_genomes.pids
log=${work}/${dir_log}/run_genomes.log
rm -rf  $pids $log && touch $pids $log

#build script to run genome relevant job
script=${work}/${dir_sh}/00_run_genomes.sh
rm -rf $script && touch $script && chmod 751 $script

#write info into script
code_num=$#
sh_prefix=${work}/${dir_sh}
sh_suffix="_bwa_idx.sh"
#write each job into script\
for i in $(seq 1 $code_num)
do
	eval code=\$$i
	job=${sh_prefix}/${code}${sh_suffix}
	echo -e "\n#genome $code" >> $script
	echo "echo \"genome $code start analysis!\"" >> $script
	echo "nohup sh ${job} >> $log 2>&1 &" >> $script
	echo "echo \$! >> $pids" >> $script
done

#echo check job status into script
echo -e "\n#check above job status, exit when all jobs are complete" >> $script
duration=${sleep_time}
echo "sh ${work}/${dir_tool}/${sh_update} $pids ${duration}" >> $script

#echo complete info
echo ">>>>>Script generated at: $script"
