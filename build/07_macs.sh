#!/bin/bash
#title  build_macs.sh
#author j1angvei
#date   20160421
#usage  using macs to do peak calling
#===============================================================

#init parameter
work=`pwd`

#check input paramter
if [ $# -lt 3 ]
then
	echo 'Usage: sh 07_macs.sh [code] [has control] [genome size] '
	exit
fi

#experiment code
code=$1
control=$2
size=$3

#import config
source config/executable.conf
source config/directory.conf

#parameter to run script
exe=${work}/${dir_exe}/${macs}
t=${work}/${dir_out}/${bam_sort}/${code}_t.sam.bam_sorted.bam
c=${work}/${dir_out}/${bam_sort}/${code}_c.sam.bam_sorted.bam
out=${work}/${dir_out}/${macs_wig}
prefix=${out}/${code}

#if out directory not exist, create one
if [ ! -e $out ]
then mkdir -p $out
fi

#generate script
script=${work}/${dir_sh}/${code}_macs.sh
rm -rf $script && touch $script && chmod 751 $script

#add info into script
if [ "$control" = 'T' ]
then 
	echo "$exe -t $t -c $c -f BAM -g $size -n $prefix -w -S " >> $script
else	
	echo "$exe -t $t -f BAM -g $size -n $prefix -w -S " >> $script
fi

#complete info
echo -e ">>>>>Script generated at: ${script} \n"

