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
if [ $# -lt 8 ]
then 
	echo 'Usage: sh build_trimmomatic.sh [code] [thread] [placeholder min len] [placeholder phred ] [treatment 1] [treatment 2] [control 1] [control 2]'
	exit
fi

#accept input parameter 
code=$1
thread=$2
param="LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 AVGQUAL:20 MINLEN:${3}"

#import user config
source config/executable.conf
source config/directory.conf

#parameter to run script
adapter_t=${work}/output/${qc}/${code}/t_adapter.fa
adapter_c=${work}/output/${qc}/${code}/c_adapter.fa
param_t="ILLUMINACLIP:${adapter_t}:2:30:10 $param"
param_c="ILLUMINACLIP:${adapter_c}:2:30:10 $param"

#paramter for trimmomatic
exe=${work}/software/${trimmomatic}
in=${work}/input/${code}
out=${work}/output/${trim}

#generate script
script=${work}/script/${code}_trimmomatic.sh
rm -rf $script && touch $script && chmod 751 $script

#treatment
if [ "$6"  = 'NULL' ]
then
	#se mode 
	echo "$java -jar $exe SE -thread $thread $4 ${in}/$5 ${out}/${code}_t.fastq ${param_t} " >> $script
else
	#pe mode
	echo "$java -jar $exe PE -thread $thread $4 ${in}/$5 ${in}/$6 ${out}/${code}_t1_paired.fastq ${out}/${code}_t1_unpaired.fastq ${out}/${code}_t2_paired.fastq ${out}/${code}_t2_unpaired.fastq ${param_t} " >> $script
fi

#control
if [ "$7" != 'NULL' ]
then
	if [ "$8" = 'NULL' ]
	then
       		 #se mode 
       		 echo "$java -jar $exe SE -thread $thread $4 ${in}/$7 ${out}/${code}_c.fastq ${param_c} " >> $script
	else 
		#pe mode
       		 echo "$java -jar $exe PE -thread $thread $4 ${in}/$7 ${in}/$8 ${out}/${code}_c1_paired.fastq ${out}/${code}_c1_unpaired.fastq ${out}/${code}_c2_paired.fastq ${out}/${code}_c2_unpaired.fastq ${param_c} ">> $script
	fi
fi

#output complete info	
echo -e ">>>>>Script generated at: $script \n"
