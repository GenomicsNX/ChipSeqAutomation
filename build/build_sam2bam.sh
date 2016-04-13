#!/bin/bash
#title	build_sam2bam.sh
#author	j1angvei
#date	20160413
#usage	convert sam file to bam file, which file name is *.sam.bam
#==========================================================================================

#init parameter
pid=$$
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
source config/output.conf

#parameter to convert sam to bam
exe=${work}/${dir_exe}/${samtools}
in=${work}/${dir_in}/${bwa_mem}
out=${work}/${dir_out}/${sam2bam}

#generate script
script=script/${code}_sam2bam.sh
rm -rf $script && touch $script && chmod 751 $script

#write info into script
for n in ${code}_*.sam
do
	echo "$exe view -bS ${in}$n > ${out}$n" >> $script
done

#output complete info
echo -e ">>>>>Complete<<<<<< sam2bam script $code generated at: ${work}/${script} \n"
