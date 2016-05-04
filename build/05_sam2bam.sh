#!/bin/bash
#title	build_sam2bam.sh
#author	j1angvei
#date	20160413
#usage	convert sam file to bam file, which file name is *.sam.bam
#==========================================================================================

#init parameter
work=`pwd`

#check parameter of input
if [ $# -lt 1 ]
then 
	echo 'Usage: sh script [code]'
	exit
fi

#experiment code
code=$1

#source config
source config/executable.conf
source config/directory.conf

#parameter to convert sam to bam
exe=${work}/${dir_exe}/${samtools}
in=${work}/${dir_out}/${bwa_mem}
out=${work}/${dir_out}/${sam_bam}

#generate script
script=${work}/${dir_sh}/${code}_sam2bam.sh
rm -rf $script && touch $script && chmod 751 $script

#write info into script
for n in ${in}/${code}_*.sam
do
	file=${n##*/}
	echo "$exe view -bS ${in}/${file} > ${out}/${file}" >> $script
done
cd $work

#output complete info
echo -e ">>>>>Script generated at: ${script} \n"
