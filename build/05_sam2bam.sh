#!/bin/bash
#title	build_sam2bam.sh
#author	j1angvei
#date	20160413
#usage	convert sam file to bam file, which file name is *.sam.bam
#==========================================================================================

#init parameter
work=`pwd`

#check parameter of input
if [ $# -lt 2 ]
then 
	echo 'Usage: sh script [code] [has control]'
	exit
fi

#experiment code
code=$1
control=$2

#source config
source config/executable.conf
source config/directory.conf
source config/preference.conf

#parameter to convert sam to bam
exe=${work}/${dir_exe}/${samtools}
in=${work}/${dir_out}/${bwa_mem}/${code}
out=${work}/${dir_out}/${sam_bam}/${code}
thread=${thread_num}

#if out directory not exist, create one
if [ ! -e $out ]
then mkdir -p $out
fi

#generate script
script=${work}/${dir_sh}/${code}_sam2bam.sh
rm -rf $script && touch $script && chmod 751 $script

#convert sam file to bam file and check alignment quality
for s in 't' 'c'
do
	sam=${in}_${s}.sam
	bam=${out}_${s}.bam
	if [ -e ${sam} ]
	then
		echo -e "\n#convert $sam to $bam " >> $script
		echo "echo \"convert $sam to $bam\"">> $script
		echo "$exe view --threads $thread -bS $sam -o $bam" >> $script
		echo -e "\n#check alignment quality of $bam" >> $script
		echo "echo \"check alignment quality of $bam\"" >> $script
		echo "$exe flagstat ${bam}" >> $script
	fi
done


#treatment convert sam file to bam, and check alignment quality
#echo -n "\n#convert treatment sam file to bam" >> $script
#echo "echo \"convert ${in}_t.sam ---> ${out}_t.bam\""
#echo "$exe view --threads $thread -bS ${in}_t.sam -o ${out}_t.bam " >> $script
#echo "$exe flagstat ${out}_t.bam" >> $script

#control convert sam file to bam, and check alignment quality
#if [ "$control" = 'T' ]
#then
#	echo "$exe view --threads $thread -bS ${in}_c.sam -o ${out}_c.bam " >> $script
#	echo "$exe flagstat ${out}_c.bam" >> $script
#fi

#output complete info
echo ">>>>>Script generated at: ${script}"
