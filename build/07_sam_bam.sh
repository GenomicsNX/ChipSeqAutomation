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
source config/preference.conf

#parameter to convert sam to bam
exe=${work}/${dir_exe}/${samtools}
out=${work}/${dir_out}/${sam_bam}
sam=${work}/${dir_out}/${bwa_mem}/${code}.sam
bam=${out}/${code}.bam
thread=${thread_num}

#if out directory not exist, create one
if [ ! -e $out ]
then mkdir -p $out
fi

#generate script
script=${work}/${dir_sh}/${code}_sam_bam.sh
rm -rf $script && touch $script && chmod 751 $script

#convert sam file to bam file and check alignment quality
echo -e "\n#convert $sam to $bam " >> $script
echo "echo \"convert $sam to $bam\"">> $script
echo "$exe view --threads $thread -bS $sam -o $bam" >> $script

#check bam file's alignment quality
echo -e "\n#check alignment quality of $bam" >> $script
echo "echo \"check alignment quality of $bam\"" >> $script
echo "$exe flagstat ${bam}" >> $script

#output complete info
echo ">>>>>Script generated at: ${script}"
