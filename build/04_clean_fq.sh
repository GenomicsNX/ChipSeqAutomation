#!/bin/bash
#title  clean_fq.sh
#author j1angvei
#date   20160514
#usage  do quality control assessment for already trimmed fastq file, using fastq
#===============================================================

#init param
work=`pwd`

#check passing arguments
if [ $# -lt 2 ]
then
	echo "Usage: sh clean_fq.sh <code> <pe>"
	exit
fi

#import relative config
source config/directory.conf
source config/executable.conf
source config/preference.conf

#accept all input paramters
code=$1
pe=$2
thread=${thread_num}

#define parameters for what fastqc needs
exe=${work}/${dir_exe}/${fastqc}
in=${work}/${dir_out}/${trim}/${code}
out=${work}/${dir_out}/${dir_clean}

#check if output directory is exist, if not, create one
if [ ! -e $out ]
then
	mkdir -p $out
fi

#generate scripts
script=${work}/${dir_sh}/${code}_clean.sh
rm -rf $script && touch $script && chmod 751 $script

#write info into scripts
for fq in ${in}_*_paired.fastq 
do
	echo -e "\n#do fastqc after trimmomatic for $fq" >> $script
	echo "$exe -o ${out} -t $thread $fq" >> $script
done

#output complete info
echo ">>>>>Script generated at: $script"
