#!/bin/bash
#title	build_sam2bam.sh
#author	j1angvei
#date	20160413
#usage	convert sam file to bam file, which file name is *.sam.bam
#==========================================================================================

#init parameter
work=`pwd`

#check parameter of input
if [ $# -lt 2 ]
then 
	echo 'Usage: sh script [code] [has control]'
	exit
fi

#experiment code
code=$1
control=$2

#source config
source config/executable.conf
source config/directory.conf
source config/preference.conf

#parameter to convert sam to bam
exe=${work}/${dir_exe}/${samtools}
in=${work}/${dir_out}/${bwa_mem}
out=${work}/${dir_out}/${sam_bam}
thread=${thread_num}

#if out directory not exist, create one
if [ ! -e $out ]
then mkdir -p $out
fi

#generate script
script=${work}/${dir_sh}/${code}_sam2bam.sh
rm -rf $script && touch $script && chmod 751 $script

#treatment sam file to bam
echo "$exe view --threads $thread -bS ${in}/${code}_t.sam -o ${out}/${code}_t.bam " >> $script

#control sam file to bam
if [ "$control" = 'T' ]
then
	echo "$exe view --threads $thread -bS ${in}/${code}_c.sam -o ${out}/${code}_c.bam " >> $script
fi

#output complete info
echo -e ">>>>>Script generated at: ${script} \n"
