#!/bin/bash
#title  qsub.sh
#author j1angvei
#date   20160514
#usage  use qsub to submit analysis job
#==========================================================================================

#init parameter
work=`pwd`

#import settting
source config/directory.conf	

echo "sh ${work}/main.sh" | qsub -l nodes=1:ppn=4,walltime=1200:00:00 -N qsub_main -d ${work} -e ${work}/${dir_log} -o ${work}/${dir_log}
echo -e "submit job successfully! log file located at ${work}/${dir_log}."
