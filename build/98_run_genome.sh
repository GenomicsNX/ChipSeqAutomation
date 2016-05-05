#!/bin/bash
#title  98_run_genome.sh
#author j1angvei
#date   20160504
#usage  run all genome relevant scripts(build genome idx, etc.)
#==========================================================================================

#init parameter
work=`pwd`

#test if parameter was correct 
if [ $# -lt 1 ]
then
	echo "Usage: sh 98_run_genome.sh [genome number] [genome number] ..."
	exit
fi

