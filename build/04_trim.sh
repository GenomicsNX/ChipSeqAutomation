#!/bin/bash
#title  build_trimmomatic.sh
#author j1angvei
#date   20160412
#usage  data filter for fastq file using trimmomatic.jar
# Other parameter, ILLUMINACLIP:/path/TruSeq5-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 AVGQUAL:20 MINLEN:50
#==========================================================================================

#init parameter
work=`pwd`
#check input parameter
if [ $# -lt 3 ]
then 
	echo 'Usage: sh build_trimmomatic.sh [code] [fastq R1] [fastq R2]'
	exit
fi

#import user config
source config/executable.conf
source config/directory.conf
source config/preference.conf

#accept input parameter 
code=$1
t1=$2
t2=$3

#param read from preference.conf
thread=${thread_num}
min_len=${ph_min_len}
phred=${ph_phred}

#parameter to run script
adapter=${work}/${dir_out}/${dir_fa}/${code}.fa
param="ILLUMINACLIP:${adapter}:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 AVGQUAL:20 MINLEN:${min_len}"

#paramter for trimmomatic
exe=${work}/${dir_exe}/${trimmomatic}
in=${work}/${dir_in}
out=${work}/${dir_out}/${trim}

#if out directory not exist, create one
if [ ! -e $out ]
then mkdir -p $out
fi

#generate script
script=${work}/script/${code}_trim.sh
rm -rf $script && touch $script && chmod 751 $script

#treatment
echo -e "\n#do fliter job using trimmomatic for ${code} treatment" >> $script
if [ "$t2"  = 'NULL' ]
then
	#se mode 
	echo "$java -jar $exe SE -threads $thread $phred ${in}/$t1 ${out}/${code}.fastq ${param} " >> $script
else
	#pe mode
	echo "$java -jar $exe PE -threads $thread $phred ${in}/$t1 ${in}/$t2 ${out}/${code}_1_paired.fastq ${out}/${code}_1_unpaired.fastq ${out}/${code}_2_paired.fastq ${out}/${code}_2_unpaired.fastq ${param} " >> $script
fi

#output complete info	
echo ">>>>>Script generated at: $script"
