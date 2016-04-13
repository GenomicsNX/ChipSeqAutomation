#!/bin/bash
#title  build_bam_sort.sh
#author j1angvei
#date   20160413
#usage  using samtolls to sort bam file, result named as *.bam.sorted.bam
#===============================================================

#init parametr
pid=$$
work=`pwd`

#check input parameter if correct
if [ $# -lt 1 ]
then
	echo 'Usage: sh script [code] '
	exit
fi

#experiment code
code=$1

#import config
source config/output.conf
source config/executable.conf

#paramter to run script
exe=${work}/${dir_exe}/${samtools}
in=${work}/${dir_out}/${sam2bam}
out=${work}/${dir_out}/${bam_sort}

#generate script
script=script/${code}_bam_sort.sh
rm -rf $script && touch $script && chmod 751 $script

#add info into script
for n in ${code}_*.sam.bam
do
	echo "$exe sort ${in}/${n} ${out}/${n}_sorted " >> $script
done

#output complete info
echo -e ">>>>>>>>Complete<<<<<<<<< bam_sort script $code generated at: ${work}/${script} \n"
