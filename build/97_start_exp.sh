#!/bin/bash
#title  97_rum_exp.sh
#author j1angvei
#date   20160505
#usage  build script to run spedified experiment scripts in order.
#==========================================================================================

#init parameter
work=`pwd`

#test if input parameters are correct
if [ $# -lt 1 ]
then
	echo "Usage: sh 97_start_exp.sh [code] "
	exit
fi

#receive passing arguments
code=$1

#import config
source config/directory.conf
source config/executable.conf
source config/preference.conf

#generate script
script=${work}/${dir_sh}/${code}_start.sh
rm -rf $script && touch $script && chmod 751 $script

#write info into script
sh_prefix=${work}/${dir_sh}/${code}_
log_prefix=${work}/${dir_log}/${code}_

#record start running time
echo -e "\n#mark job start time" >> $script
echo "echo \" \`date\` ${code} start analysis!\"" >> $script

#=====fastqc======  
echo -e "\n#do quality contrl using FastQC for ${code} experiment" >> $script
echo "sh ${sh_prefix}fastqc.sh > ${log_prefix}fastqc.log 2>&1" >> $script
echo "echo \" \`date\` ${code} fastqc complete!\"" >> $script

#=====qc_out======
echo -e "\n#handle qc output for experiment ${code} " >> $script
echo "sh ${sh_prefix}qc_out.sh > ${log_prefix}qc_out.log 2>&1" >> $script
echo "echo \" \`date\` ${code} qc_out complete!\" " >> $script

#=====trimmomatic======
echo -e "\n#do trim work using trimmomatic for experiment ${code}" >> $script
echo "sh ${sh_prefix}trimmomatic.sh > ${log_prefix}trimmomatic.log 2>&1" >> $script
echo "echo \" \`date\` ${code} trimmomatic complete!\" " >> $script

#=====bwa_mem=====
echo -e "\n#do alignment using bwa mem for experiment ${code}" >> $script
echo "sh ${sh_prefix}bwa_mem.sh > ${log_prefix}bwa_mem.log 2>&1 " >> $script
echo "echo \" \`date\` ${code} bwa_mem complete!\" " >> $script

#=====sam2bam=====
echo -e "\n#do convert sam file to bam file using samtools for experiment ${code}" >>$script
echo "sh ${sh_prefix}sam2bam.sh > ${log_prefix}sam2bam.log 2>&1 " >> $script
echo "echo \" \`date\` ${code} sam2bam complete!\" " >> $script

#=====bam_sort=====
echo -e "\n#do bam sort using samtools for experiment ${code}" >> $script
echo "sh ${sh_prefix}bam_sort.sh > ${log_prefix}bam_sort.log 2>&1" >> $script
echo "echo \" \`date\` ${code} bam_sort complete!\" " >> $script

#=====macs=====
echo -e "\n#do peak calling using macs for experiment ${code} " >> $script
#add environment variable to $PATH as macs requested.
echo "export PYTHONPATH=/home/jwman/chipseq-automation/software/MACS-1.4.2/lib/python2.7/site-packages:\$PYTHONPATH" >> $script
echo "export PATH=/home/jwman/chipseq-automation/software/MACS-1.4.2/bin:\$PATH" >> $script
echo "sh ${sh_prefix}macs.sh > ${log_prefix}macs.log 2>&1" >>$script
echo "echo \" \`date\` ${code} macs complete!\" " >> $script

#output complete info
echo -e "=====Script generated at: ${script} \n"
