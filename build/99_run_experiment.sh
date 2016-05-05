#!/bin/bash
#title  99_run_experiment.sh
#author j1angvei
#date   20160504
#usage  run all experiment script from fastqc to macs(current version)
#==========================================================================================

#init parameter
work=`pwd`

#test if input parameters are correct
if [ $# -lt 2 ]
then
	echo "Usage: sh 00_run_exp.sh [code]"
	exit
fi

#import config

