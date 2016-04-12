#!/bin/bash
#work dir
work=`pwd`
#echo $work

#init config
source config/environment.conf
source config/executable.conf
source config/input.conf
source config/output.conf
#fastqc
exe=$work'/'$dir_exe'/'$fastqc
echo "exe $exe"
out=$work'/'$dir_out'/'$qc
echo "out $out"
thread=10
echo "thread $thread"
all=${exp//,/ }
for code in `echo $all`
do
	sh build/build_fastqc.sh $exe $out $thread $code
done

#trimmomatic 
