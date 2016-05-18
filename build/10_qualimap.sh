#!/bin/bash
#title  10_qualimap.sh
#author j1angvei
#date   20160413
#usage  check alignment quality
#===============================================================

#init parametr
work=`pwd`

#check input parameter if correct
if [ $# -lt 1 ]
then
	echo 'Usage: sh 10_qualimap.sh <code>'
	exit
fi

#experiment code
code=$1

#import config
source config/directory.conf
source config/executable.conf

#paramter to run script
exe=${work}/${dir_exe}/${qualimap}
bam=${work}/${dir_out}/${bam_sort}/${code}_sorted.bam
out=${work}/${dir_out}/${bamqc}/${code}

#if out directory not exist, create one
if [ ! -e $out ]
then mkdir -p $out
fi

#generate script
script=${work}/${dir_sh}/${code}_qualimap.sh
rm -rf $script && touch $script && chmod 751 $script

#treatment 
echo "$exe bamqc -bam ${bam} -outdir $out" >> $script

#output complete info
echo ">>>>>Script generated at: ${script}"
