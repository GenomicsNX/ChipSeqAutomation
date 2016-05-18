#!/bin/bash
#title  build_macs.sh
#author j1angvei
#date   20160421
#usage  using homer to do peak annotation
#===============================================================

#init parameter
work=`pwd`

#check input paramter
if [ $# -lt 3 ]
then
	echo 'Usage: sh 11_homer_annotate.sh [code] [ref] [anno]'
	exit
fi

#experiment code
code=$1
ref=$2
anno=$3

#get annotation format
format="-${anno##*.}"

#import configuration
source config/executable.conf
source config/directory.conf


#parameter to run script
exe=${work}/${dir_exe}/${homer}
in=${work}/${dir_out}/${macs_wig}/${code}_peaks.bed
out=${work}/${dir_out}/${homer_anno}
prefix=${out}/${code}
ref=${work}/${dir_gen}/${ref}
anno=${work}/${dir_gen}/${anno}

#if out directory not exist, create one
if [ ! -e $out ]; then 
	mkdir -p $out
fi
out=${out}/${code}_annotation.bed

#generate script
script=${work}/${dir_sh}/${code}_homer_anno.sh
rm -rf $script && touch $script && chmod 751 $script


#add info into script
echo -e  "\n#do homer annoattion for $code" >> $script
echo "$exe $in $ref $format $anno > ${out}" >> $script

#complete info
echo ">>>>>Script generated at: ${script}"
