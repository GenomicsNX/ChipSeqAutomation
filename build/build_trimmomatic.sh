#!/bin/bash
# Generate script running trimmomatic job.
# Input parameter as exe, pe/se, -threads thread, R1.fastq (R2.fastq) R1_paried.fastq R1_unpaired.fastq (R2_paired.fastq R2_unpaired.fastq)
# Other parameter, ILLUMINACLIP:/path/TruSeq5-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 AVGQUAL:20 MINLEN:50
pid=$$
arg=$#
work=`pwd`
#check input parameter
if [ $arg -lt 1 ]
then 
	echo 'Usage: sh build_trimmomatic.sh [java] [exe] [code]'
	exit
fi
java=$1
exe=$2
code=$3
source config/exp_${code}.conf
#absolute path of all input fastq file
exp_dir=$work'/'${dir_in}'/'${code}'/'
t1=${exp_dir}'/'${treatment_1}
t2=${exp_dir}'/'${treatment_2}
c1=${exp_dir}'/'${control_1}
c2=${exp_dir}'/'${control_2}
if [ ${treatment_2} = 'YES'  ]
then
	echo "$java -jar $exe ${exp_dir}'/'${treatment_1} " 


