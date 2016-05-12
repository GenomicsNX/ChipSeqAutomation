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
species=$1
prefix=${work}/${dir_out}/${bwa_idx}/$species
ref=${work}/${dir_gen}/$2

#create directory if not exist
sub=${prefix%/*}
if [ ! -e $sub ]
then
        mkdir -p $sub
fi

#build script
script=${work}/script/${species}_bwa_idx.sh
rm -rf $script && touch $script && chmod 751 $script

#write corresponding information into script

if [ -e ${prefix}.amb -a -e ${prefix}.ann -a -e ${prefix}.bwt -a -e ${prefix}.pac -a -e ${prefix}.sa ]
then	
	#bwa index already be done	
        echo "echo 'genome index of ${species} is already done, using existed index!'" >> $script
else
	#write bwa index command into script
	echo "$exe index -p $prefix $ref" >> $script
fi

#complete message
echo -e ">>>>>Script generated at $script} \n"
