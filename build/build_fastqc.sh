#!/bin/bash'
# $$ is the pid of current script running on.
pid=$$
arg=4
work=`pwd`
if  [ $# -lt $arg ]
then
	echo 'Usage: sh build_fastqc.sh [executable] [out] [thread] [exp code]'
	exit
fi 
exe=$1
out=$2
thread=$3
code=$4
script=script/fastqc_${code}.sh

source config/input.conf
source config/exp_${code}.conf
prefix=${work}'/'${dir_in}'/'${code}'/'
echo "prefix>>>>>  $prefix"
rm -rf $script
touch $script
chmod 751 $script
#treatment 1
echo "$exe -o $out -t $thread ${prefix}${treatment_1}" >> $script
#if is pair_end, treatment 2
if [ ${pair_end} = 'YES' ]
then
	echo "$exe -o $out -t $thread ${prefix}${treatment_2}" >> $script
fi
#if has control, control_1
if [ ${has_control} = 'YES' ]
then 
	echo "$exe -o $out -t $thread ${prefix}${control_1}" >> $script
#########if pair_end, control_2
	if [ ${pair_end} = 'YES' ]
	then
		echo "$exe -o $out -t $thread ${prefix}${control_2}" >> $script
	fi
fi
