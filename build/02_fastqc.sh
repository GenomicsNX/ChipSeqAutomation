#!/bin/bash
#title  build_fastqc.sh
#author j1angvei
#date   20160412
#usage  do quality control assessment for fastq file, using fastq
#===============================================================

#init parameter
work=`pwd`

#check passing arguments
if  [ $# -lt 3 ]
then
	echo 'Usage: sh build_fastqc.sh [code] [treatment 1] [treatment 2]'
	exit
fi

#import relative config
source config/executable.conf
source config/directory.conf
source config/preference.conf

#accept all input parameters
code=$1
t1=$2
t2=$3
thread=${thread_num}

#define parameters fastqc needs
in=${work}/${dir_in}
exe=${work}/${dir_exe}/${fastqc}
out=${work}/${dir_out}/${qc}

#if out directory not exist, create one
if [ ! -e $out ]
then mkdir -p $out
fi

#generate script
script=${work}/${dir_sh}/${code}_fastqc.sh
rm -rf $script && touch $script && chmod 751 $script

#write info into script
for fq in $t1 $t2
do
	# fastq file not exist, skip this
	if [ "$fq" = 'F' ]; then
		continue
	fi

	#do qc depends on if qc already be done!
	echo -e "\n#do quality control for ${in}/${fq} " >> $script
	if [ -e ${out}/${fq%.*}_fastqc.zip -a -e ${out}/${fq%.*}_fastqc.html ]; then
		echo "#${in}/${fq} already done quality control, skip this." >> $script
	else
		echo "$exe -o $out -t $thread ${in}/${fq}" >> $script
	fi	
done

#output complete info
echo ">>>>>Script generated at: ${script}"
