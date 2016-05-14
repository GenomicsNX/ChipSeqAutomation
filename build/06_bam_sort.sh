#!/bin/bash
#title  build_bam_sort.sh
#author j1angvei
#date   20160413
#usage  using samtolls to sort bam file, result named as *.bam.sorted.bam
#===============================================================

#init parametr
work=`pwd`

#check input parameter if correct
if [ $# -lt 2 ]
then
	echo 'Usage: sh build_bam_sort.sh [code] [has control]'
	exit
fi

#experiment code
code=$1
control=$2

#import config
source config/directory.conf
source config/executable.conf
source config/preference.conf

#paramter to run script
exe=${work}/${dir_exe}/${samtools}
in=${work}/${dir_out}/${sam_bam}
out=${work}/${dir_out}/${bam_sort}
thread=${thread_num}

#if out directory not exist, create one
if [ ! -e $out ]
then mkdir -p $out
fi

#generate script
script=${work}/${dir_sh}/${code}_bam_sort.sh
rm -rf $script && touch $script && chmod 751 $script

#treatment 
echo "$exe sort ${in}/${code}_t.bam --threads $thread -o ${out}/${code}_t_sorted.bam " >> $script

#control
if [ $control = 'T' ]
then
	echo "$exe sort ${in}/${code}_c.bam --threads $thread -o ${out}/${code}_c_sorted.bam " >> $script
fi

#output complete info
echo ">>>>>Script generated at: ${script}"
