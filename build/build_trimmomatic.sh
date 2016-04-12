#!/bin/bash
# Generate script running trimmomatic job.
# Input parameter as exe, pe/se, -threads thread, R1.fastq (R2.fastq) R1_paried.fastq R1_unpaired.fastq (R2_paired.fastq R2_unpaired.fastq)
# Other parameter, ILLUMINACLIP:/path/TruSeq5-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 AVGQUAL:20 MINLEN:50
pid=$$
work=`pwd`
#check input parameter
if [ $# -lt 2 ]
then 
	echo 'Usage: sh build_trimmomatic.sh [code] [min lenght] [treatment_adapter.fa] [control_adapter.fa]'
	exit
fi

#input parameter with script
code=$1
min_len=$2
param="LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 AVGQUAL:20 MINLEN:${min_len}"
param_t=$param
param_c=$param

#treatment trim parameter
if [ $# -ge 3 ]
then 
param_t="ILLUMINACLIP:${3}:2:30:10 $param"
fi

#control trim parameter
if [ $# -eq 4 ]
then
param_c="ILLUMINACLIP:${4}:2:30:10 $param"
fi

#generate script
script=script/trimmomatic_${code}.sh
rm -rf $script
touch $script
chmod 751 $script

#import user config
source config/environment.conf
source config/executable.conf
source config/exp_${code}.conf
source config/input.conf
source config/output.conf

#paramter for trimmomatic
exe=${work}/${dir_exe}/${trimmomatic}
out=${dir_out}/${trim}

#absolute path of all input fastq file
exp_dir=${work}/${dir_in}/${code}
t1=${exp_dir}/${treatment_1}
t2=${exp_dir}/${treatment_2}
c1=${exp_dir}/${control_1}
c2=${exp_dir}/${control_2}

#treatment
if [ ${treatment_2} = 'NULL' ]
then
	#se mode 
	echo "$java -jar $exe $t1 ${out}/${code}_${treatment_1} ${param_t} " >> $script
else
	#pe mode
	echo "$java -jar $exe $t1 $t2 ${out}/${code}_paired_${treatment_1} ${out}/${code}_unpaired_${treatment_1} ${out}/${code}_paired_${treatment_2} ${out}/${code}_unpaired_${treatment_2} ${param_t} " >> $script
fi

#control se
if [ ${control_1} != 'NULL' ]
then
	if [ ${control_2} = 'NULL' ]
	then
       		 #se mode 
       		 echo "$java -jar $exe $c1 ${out}/${code}_${control_1} ${param_c} " >> $script
	else 
		#pe mode
       		 echo "$java -jar $exe $c1 $c2 ${out}/${code}_paired_${control_1} ${out}/${code}_unpaired_${control_1} ${out}/${code}_paired_${control_2} ${out}/${code}_unpaired_${control_2} ${param_t} ">> $script
	fi
fi
echo -e "build trimmmomatic.sh complete!\nfile location: ${work}/$script"
