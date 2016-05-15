#!/bin/bash
#title  qsub.sh
#author j1angvei
#date   20160514
#usage  use qsub to submit analysis job
#==========================================================================================

#init parameter
work=`pwd`

#import configuration
source config/directory.conf	

#echo command to qsub
echo "sh ${work}/main.sh" | qsub -l nodes=1:ppn=4,walltime=1200:00:00 -N QSUB_CHIPSEQ -d ${work} -e ${work}/${dir_log} -o ${work}/${dir_log}

#echo submit successfully information
echo -e "submit job successfully! log file located at ${work}/${dir_log}."
