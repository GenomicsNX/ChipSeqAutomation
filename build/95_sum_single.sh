#!/bin/bash
#title  95_sum_single.sh
#author j1angvei
#date   20160517
#usage  build script to run single experiment scripts in order.
#==========================================================================================

#init parameter
work=`pwd`

#test if input parameters are correct
if [ $# -lt 1 ]
then
	echo "Usage: sh 95_sum_single.sh [code]"
	exit
fi

#receive passing arguments
code=$1

#import config
source config/directory.conf

#generate script
script=${work}/${dir_sh}/${code}_single.sh
rm -rf $script && touch $script && chmod 751 $script

#write info into script
sh_prefix=${work}/${dir_sh}/${code}_
log_prefix=${work}/${dir_log}/${code}_

#record start running time
echo -e "\n#mark job start time" >> $script
echo "echo \" \`date\` ${code} start analysis!\"" >> $script

#=====fastqc======  
echo -e "\n#do quality contrl using FastQC for ${code} experiment" >> $script
echo "echo \" \`date\` >>>>>${code} fastqc START!\"" >> $script
echo "sh ${sh_prefix}fastqc.sh > ${log_prefix}fastqc.log 2>&1" >> $script
echo "echo \" \`date\` <<<<<${code} fastqc FINISH!\"" >> $script

#=====qc_out======
echo -e "\n#handle qc output for experiment ${code} " >> $script
echo "echo \" \`date\` >>>>>${code} qc_out START!\"" >> $script
echo "sh ${sh_prefix}qc_out.sh > ${log_prefix}qc_out.log 2>&1" >> $script
echo "echo \" \`date\` <<<<<${code} qc_out FINISH!\" " >> $script

#=====trimmomatic======
echo -e "\n#do trim work using trimmomatic for experiment ${code}" >> $script
echo "echo \" \`date\` >>>>>${code} trimmomatic START!\"" >> $script
echo "sh ${sh_prefix}trim.sh > ${log_prefix}trim.log 2>&1" >> $script
echo "echo \" \`date\` <<<<<${code} trimmomatic FINISH!\" " >> $script

#=====do fastqc after trim=====
echo -e "\n#do fastqc using fastqc for experiment ${code}" >> $script
echo "echo \" \`date\` >>>>>${code} fastqc again START!\"" >> $script
echo "sh ${sh_prefix}clean.sh >${log_prefix}clean.log 2>&1" >> $script
echo "echo \"\`date\` <<<<<${cdoe} fastqc again submit successfully, pid is \$! \"" >> $script

#=====bwa_mem=====
echo -e "\n#do alignment using bwa mem for experiment ${code}" >> $script
echo "echo \" \`date\` >>>>>${code} bwa mem alignment  START!\"" >> $script
echo "sh ${sh_prefix}bwa_mem.sh > ${log_prefix}bwa_mem.log 2>&1 " >> $script
echo "echo \" \`date\` >>>>>${code} bwa mem alignment FINISH!\" " >> $script

#=====sam2bam=====
echo -e "\n#do convert sam file to bam file using samtools for experiment ${code}" >>$script
echo "echo \" \`date\` >>>>>${code} sam2bam convert START!\"" >> $script
echo "sh ${sh_prefix}sam_bam.sh > ${log_prefix}sam_bam.log 2>&1 " >> $script
echo "echo \" \`date\` <<<<<${code} sam2bam convert FINISH!\" " >> $script

#=====bam_sort=====
echo -e "\n#do bam sort using samtools for experiment ${code}" >> $script
echo "echo \" \`date\` >>>>>${code} bam sort START!\"" >> $script
echo "sh ${sh_prefix}bam_sort.sh > ${log_prefix}bam_sort.log 2>&1" >> $script
echo "echo \" \`date\` <<<<<${code} bam sort FINISH!\" " >> $script

#=====qualimap=====
echo -e "\n#do qualimap for alignment bam file for experiment ${code}" >> $script
echo "echo \" \`date\` >>>>>${code} qualimap START!\"" >> $script
echo "sh ${sh_prefix}qualimap.sh > ${log_prefix}qualimap.log 2>&1" >> $script
echo "echo \" \`date\` <<<<<${code} qualimap FINISH!\" " >> $script

#=====All done======
echo ">>>>>Script generated at: ${script}."
