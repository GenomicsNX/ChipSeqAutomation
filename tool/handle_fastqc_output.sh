#!/bin/bash
#title  handle_qc_output.sh
#author j1angvei
#date   20160505
#usage  read fastqc output and pass result to trimmomatic.sh(replace placeholder)
#==========================================================================================
work=`pwd`

#test if input parameters are correct
if [ $# -lt 6 ]
then
        echo "Usage: sh handle_qc_output.sh [jar] [dir] [treatment 1] [treatment 2] [control 1] [control 2] "
        exit
fi

#receive passing arguments
jar=$1
dir=$2
t1=$3
t2=$4
c1=$5
c2=$6

#dealing with every zip file
for zip in ${dir}/*.zip
do

done

