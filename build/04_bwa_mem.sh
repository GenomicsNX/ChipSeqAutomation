#!/bin/bash
#title  build_bwa_mem.sh
#author j1angvei
#date   20160413
#usage  do alignment work for fastq file using bwa mem
#==========================================================================================

#init paramter
work=`pwd`

#check if  input parameter is correct
if [ $# -lt 5 ]
then
	echo "Usage: sh build_bwa_mem.sh [code] [thread] [species] [T if pe] [T has control]"
	exit
fi

#experiment code
code=$1
thread=$2
species=$3
pe=$4
control=$5

#import config
source config/executable.conf
source config/directory.conf

#parametr to do bwa mem
exe=${work}/software/${bwa}
idx=${work}/output/${bwa_idx}/${species}

#input file name, from previous step, trimmomatic
comm_prefix=${work}/output/${trim}/${code}_
t=${comm_prefix}t.fastq
c=${comm_prefix}c.fastq
t1=${comm_prefix}t1_paired.fastq
t2=${comm_prefix}t2_paired.fastq
c1=${comm_prefix}c1_paired.fastq
c2=${comm_prefix}c2_paired.fastq

#output file name
t_sam=${work}/output/${bwa_mem}/${code}_t.sam
c_sam=${work}/output/${bwa_mem}/${code}_c.sam

#generate script
script=${work}/script/${code}_bwa_mem.sh
rm -rf $script && touch $script && chmod 751 $script

if [ "$pe" = 'T' ]
then
	#pe treatment
	echo "$exe mem $idx -t $thread $t1 $t2 ${t_sam} " >> $script

	#pe control
	if [ "$control" = 'T' ]
	then 
		echo "$exe mem $idx -t $thread $c1 $c2 ${c_sam} " >> $script
	fi

else
	#se treatment
	echo "$exe mem $idx -t $thread $t ${t_sam} " >> $script
	
	#se control
	if [ "$control" = 'T' ]
	then 
		echo "$exe mem $idx -t $thread $c ${c_sam} " >> $script
	fi
fi

#complete
echo -e ">>>>>Script generated at: ${script} \n"
