#!/bin/bash

#current work directory
work=`pwd`
pid=$$

#init config
source config/input.conf
source config/output.conf

#number of total experiment
n=$total

#generate script for all experiments
for ((i=1; i<=$n; i++ )) ;
do
	exp=exp$i
	code=${!exp}
	
	#generate fastqc script
	sh build/build_fastqc.sh $code
	
	#generate trimmomatic script
	sh build/build_trimmomatic.sh $code 23 t_adapter.fa c_adapter.fa #mock 3 parameters, deal later
done

#trimmomatic 
