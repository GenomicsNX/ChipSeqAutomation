#!/bin/bash'
# $$ is the pid of current script running on.
pid=$$
work=`pwd`
if  [ $# -lt 1 ]
then
	echo 'Usage: sh build_fastqc.sh [code]'
	exit
fi

#experiment code
code=$1

#relative path of generated script
script=script/fastqc_${code}.sh
rm -rf $script && touch $script && chmod 751 $script

#import relative config
source config/input.conf
source config/executable.conf
source config/output.conf
source config/exp_${code}.conf

#absolute path of experiment data directory
exp_dir=${work}'/'${dir_in}'/'${code}'/'

#define parameter of what fastqc need
exe=${work}'/'${dir_exe}'/'${fastqc}
out=${work}'/'${dir_out}'/'${qc}
thread=10

#if out directory not exist, create one
if [ ! -e $out ]
then mkdir $out
fi

#treatment 1
echo "$exe -o $out -t $thread ${exp_dir}${treatment_1} " >> $script
#treatment 2
if [ ${treatment_2} != 'NULL' ] 
then
	echo "$exe -o $out -t $thread ${exp_dir}${treatment_2}" >> $script
fi
#control 1
if [ ${control_1} != 'NULL' ] 
then
        echo "$exe -o $out -t $thread ${exp_dir}${control_1}" >> $script
fi
#control 2
if [ ${control_2} != 'NULL' ] 
then
        echo "$exe -o $out -t $thread ${exp_dir}${control_2}" >> $script
fi
echo -e "fastqc scirpt $code generated at: ${work}/$script"
