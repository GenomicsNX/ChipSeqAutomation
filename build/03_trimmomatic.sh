#!/bin/bash
#title  build_trimmomatic.sh
#author j1angvei
#date   20160412
#usage  data filter for fastq file using trimmomatic.jar
# Input parameter as exe, pe/se, -threads thread, R1.fastq (R2.fastq) R1_paried.fastq R1_unpaired.fastq (R2_paired.fastq R2_unpaired.fastq)
# Other parameter, ILLUMINACLIP:/path/TruSeq5-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 AVGQUAL:20 MINLEN:50
#==========================================================================================

#init parameter
work=`pwd`
#check input parameter
if [ $# -lt 5 ]
then 
	echo 'Usage: sh build_trimmomatic.sh [code] [treatment 1] [treatment 2] [control 1] [control 2]'
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
c1=$4
c2=$5

#param read from preference.conf
thread=${thread_num}
min_len=${ph_min_len}
phred=${ph_phred}

#parameter to run script
param="LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 AVGQUAL:20 MINLEN:${min_len}"
adapter_t=${work}/${dir_out}/${qc}/${code}/t_adapter.fa
adapter_c=${work}/${dir_out}/${qc}/${code}/c_adapter.fa
param_t="ILLUMINACLIP:${adapter_t}:2:30:10 $param"
param_c="ILLUMINACLIP:${adapter_c}:2:30:10 $param"

#paramter for trimmomatic
exe=${work}/software/${trimmomatic}
in=${work}/input/${code}
out=${work}/output/${trim}

#if out directory not exist, create one
if [ ! -e $out ]
then mkdir -p $out
fi

#generate script
script=${work}/script/${code}_trimmomatic.sh
rm -rf $script && touch $script && chmod 751 $script

#treatment
if [ "$t2"  = 'NULL' ]
then
	#se mode 
	echo "$java -jar $exe SE -threads $thread $phred ${in}/$t1 ${out}/${code}_t.fastq ${param_t} " >> $script
else
	#pe mode
	echo "$java -jar $exe PE -threads $thread $phred ${in}/$t1 ${in}/$t2 ${out}/${code}_t1_paired.fastq ${out}/${code}_t1_unpaired.fastq ${out}/${code}_t2_paired.fastq ${out}/${code}_t2_unpaired.fastq ${param_t} " >> $script
fi

#control
if [ "$c1" != 'NULL' ]
then
	if [ "$c2" = 'NULL' ]
	then
       		 #se mode 
       		 echo "$java -jar $exe SE -threads $thread $phred ${in}/$c1 ${out}/${code}_c.fastq ${param_c} " >> $script
	else 
		#pe mode
       		 echo "$java -jar $exe PE -threads $thread $phred ${in}/$c1 ${in}/$c2 ${out}/${code}_c1_paired.fastq ${out}/${code}_c1_unpaired.fastq ${out}/${code}_c2_paired.fastq ${out}/${code}_c2_unpaired.fastq ${param_c} ">> $script
	fi
fi

#output complete info	
echo -e ">>>>>Script generated at: $script \n"
