#!/bin/bash

#current work directory
work=`pwd`
pid=$$

#init config
source config/input.conf
source config/output.conf

#number of total experiment
n=$total

#fastqc
for ((i=1; i<=$n; i++ )) ;
do
	exp=exp$i
	sh build/build_fastqc.sh ${!exp}
done

#trimmomatic 
