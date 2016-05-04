#!/bin/bash
#title  build_bam_sort.sh
#author j1angvei
#date   20160413
#usage  using samtolls to sort bam file, result named as *.bam.sorted.bam
#===============================================================

#init parametr
work=`pwd`

#check input parameter if correct
if [ $# -lt 1 ]
then
	echo 'Usage: sh build_bam_sort.sh [code] '
	exit
fi

#experiment code
code=$1

#import config
source config/directory.conf
source config/executable.conf

#paramter to run script
exe=${work}/${dir_exe}/${samtools}
in=${work}/${dir_out}/${sam_bam}
out=${work}/${dir_out}/${bam_sort}

#generate script
script=${work}/${dir_sh}/${code}_bam_sort.sh
rm -rf $script && touch $script && chmod 751 $script

#add info into script
for n in ${in}/${code}_*.sam.bam
do
	file=${n##*/}
	echo "$exe sort ${in}/${file} ${out}/${file}_sorted " >> $script
done

#output complete info
echo -e ">>>>>Script generated at: ${work}/${script} \n"
