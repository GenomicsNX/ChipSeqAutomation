#!/bin/bash
#title  build_bwa_idx.sh
#author j1angvei
#date   20160412
#usage  generate index for reference genome using bwa idx
#==========================================================================================

#init parameter
work=`pwd`

#test if parameter was correct 
if [ $# -lt 1 ]
then
	echo "Usage: sh script.sh  [code] "
	exit
fi

#experiment code
code=$1

#import experiment to retrieve $species
source config/exp_${code}.conf

#import config
source config/genome_${species}.conf
source config/executable.conf
source config/output.conf

#assebmle parameter to run bwa idx
exe=${work}/${dir_exe}/${bwa}
prefix=${work}/${dir_out}/${bwa_idx}/${code}
ref=${work}/${dir_gen}/${reference}

#build script
script=script/${code}_bwa_idx.sh
rm -rf $script && touch $script && chmod 751 $script
echo "$exe index -p $prefix $ref" >> $script

#complete message
echo -e ">>>>>Script generated at $work/${script} \n"

