#!/bin/bash
#title  build_macs.sh
#author j1angvei
#date   20160421
#usage  using macs to do peak calling
#===============================================================

#init parameter
work=`pwd`

#check input paramter
if [ $# -lt 1 ]
then
	echo 'Usage: sh build_macs.sh [code] '
	exit
fi

#experiment code
code=$1

#import config
source config/executable.conf
source config/output.conf
source config/exp_${code}.conf
source config/genome_${species}.conf

#parameter to run script
exe=${work}/${dir_exe}/${macs}
t=${work}/${dir_out}/${bam_sort}/${code}_t.sam.bam_sorted.bam
c=${work}/${dir_out}/${bam_sort}/${code}_c.sam.bam_sorted.bam
prefix=${work}/${dir_out}/${macs_wig}/${code}

#cout genome length
ref=${work}/${dir_gen}/${reference}
len=`wc -c $ref`
len=${len% *}

#generate script
script=script/${code}_macs.sh
rm -rf $script && touch $script && chmod 751 $script

#add info into script
if [ -e $c ]
then 
	echo "$exe -t $t -c $c -f BAM -g $len -n $prefix -w -S " >> $script
else	
	echo "$exe -t $t -f BAM -g $len -n $prefix -w -S " >> $script
fi

#complete info
echo -e ">>>>>Script generated at: ${work}/${script} \n"

