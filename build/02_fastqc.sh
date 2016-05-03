#!/bin/bash
#title  build_fastqc.sh
#author j1angvei
#date   20160412
#usage  do quality control assessment for fastq file, using fastq
#===============================================================

work=`pwd`
if  [ $# -lt 6 ]
then
	echo 'Usage: sh build_fastqc.sh [code] [treatment 1] [treatment 2] [control 1] [control 2] [thread]'
	exit
fi

#accept all input parameters
code=$1
thread=$6

#import relative config
source config/executable.conf
source config/directory.conf

#define parameters fastqc needs
in=${work}/input/${code}
exe=${work}/software/${fastqc}
out=${work}/output/${qc}

#if out directory not exist, create one
if [ ! -e $out ]
then mkdir -p $out
fi

#generate script
script=${work}/script/${code}_fastqc.sh
rm -rf $script && touch $script && chmod 751 $script

#treatment 1
echo "$exe -o $out -t $thread ${in}/$2 " >> $script

#treatment 2
if [ $3 != 'NULL' ] 
then
	echo "$exe -o $out -t $thread ${in}/$3 " >> $script
fi
#control 1
if [ $4 != 'NULL' ] 
then
        echo "$exe -o $out -t $thread ${in}/$4 " >> $script
fi

#control 2
if [ $5 != 'NULL' ] 
then
        echo "$exe -o $out -t $thread ${in}/$5 " >> $script
fi

#output complete info
echo -e ">>>>>Script generate at: ${script} \n"
