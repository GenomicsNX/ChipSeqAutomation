#!/bin/bash
#title  build_bwa_idx.sh
#author j1angvei
#date   20160412
#usage  generate index for reference genome using bwa idx
#==========================================================================================

#init parameter
work=`pwd`

#test if parameter was correct 
if [ $# -lt 2 ]
then
	echo "Usage: sh script.sh  [species number] [genome reference file] "
	exit
fi

#import config
source config/executable.conf
source config/directory.conf

#assebmle parameter to run bwa idx
exe=${work}/${dir_exe}/${bwa}
#using species number as prefix
prefix=${work}/${dir_out}/${bwa_idx}/$1
ref=${work}/${dir_gen}/$2

#create directory if not exist
sub=${prefix%/*}
if [ ! -e $sub ]
then
	mkdir -p $sub
fi

#build script
script=${work}/script/${1}_bwa_idx.sh
rm -rf $script && touch $script && chmod 751 $script
echo "$exe index -p $prefix $ref" >> $script

#complete message
echo -e ">>>>>Script generated at $script} \n"

