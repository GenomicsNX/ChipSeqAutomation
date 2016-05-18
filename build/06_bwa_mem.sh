#!/bin/bash
#title  build_bwa_mem.sh
#author j1angvei
#date   20160413
#usage  do alignment work for fastq file using bwa mem
#==========================================================================================

#init paramter
work=`pwd`

#check if  input parameter is correct
if [ $# -lt 3 ]
then
	echo "Usage: sh build_bwa_mem.sh [code] [species] [T if pe]"
	exit
fi

#import config
source config/executable.conf
source config/directory.conf
source config/preference.conf

#receiving passing argument and 
code=$1
species=$2
pe=$3

#read parameter from preference.conf
thread=${thread_num}

#parametr to do bwa mem
exe=${work}/${dir_exe}/${bwa}
idx=${work}/${dir_out}/${bwa_idx}/${species}
out=${work}/${dir_out}/${bwa_mem}

#if out directory not exist, create one
if [ ! -e $out ]
then mkdir -p $out
fi

#input file name, from previous step, trimmomatic
prefix=${work}/${dir_out}/${trim}/${code}

#output file name
sam=${out}/${code}.sam

#generate script
script=${work}/${dir_sh}/${code}_bwa_mem.sh
rm -rf $script && touch $script && chmod 751 $script



if [ "$pe" = 'T' ]; then
	#pe treatment
	echo "$exe mem $idx -t $thread ${prefix}_1_paired.fastq ${prefix}_2_paired.fastq > ${sam} " >> $script
else
	#se treatment
	echo "$exe mem $idx -t $thread ${prefix}.fastq > ${sam} " >> $script
fi

#complete info
echo ">>>>>Script generated at: ${script}"
