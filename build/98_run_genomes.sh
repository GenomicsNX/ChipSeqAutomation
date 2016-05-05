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
	echo "Usage: sh 98_run_genome.sh [genome scripts] "
	exit
fi
#import config
source config/directory.conf
source config/executable.conf

#create files to store pids and logs
pids=${work}/${dir_pid}/run_genomes.pids
log=${work}/${dir_log}/run_genomes.log
rm -rf  $pids $log && touch $pids $log

#build script to run genome relevant job
script=${work}/${dir_sh}/run_genomes.sh
rm -rf $script && touch $script && chmod 751 $script

#write info into script
all_jobs=$1

#write each job into script
for s in ${all_jobs}
do
	echo "# job $s" >> $script
	echo "nohup sh $s >> $log 2>&1 &" >> $script
	echo -e "echo \$! >> $pids \n" >> $script
done

#echo check job status into script
word=genome_bwa_idx
echo "sh ${work}/${dir_tool}/${sh_update} $pids $word" >> $script

#echo complete info
echo -e "======Script generated at $script \n"

