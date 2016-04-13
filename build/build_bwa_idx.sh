#!/bin/bash
#title  build_bwa_idx.sh
#author j1angvei
#date   20160412
#usage  generate index for reference genome using bwa idx
#==========================================================================================

#init parameter
pid=$$
work=`pwd`

#test if parameter was correct 
if [ $# -lt 1 ]
then
	echo "Usage: sh script.sh  [code] "
	exit
fi

#experiment code
code=$1

#import config
source config/genome.conf
source config/executable.conf
source config/output.conf

#check if should use default genome, if no, overvide the default
if [ -e config/genome_${code}.conf ]
then
	source config/genome_${code}.conf
fi

#assebmle parameter to run bwa idx
exe=${work}/${dir_exe}/${bwa}
prefix=${work}/${dir_out}/${code}
ref=${work}/${dir_gen}/${reference}

#build script
script=script/${code}_bwa_idx_.sh
rm -rf $script && touch $script && chmod 751 $script
echo "$exe index -p $prefix $ref" >> $script

#complete message
echo -e ">>>>>> Complete <<<<<< bwa idx script $code generated at $work/${scripit} \n"

