#!/bin/bash

#init, remove old file
#rm -rf output/*

#current work directory
work=`pwd`
pid=$$

#init config
source config/input.conf
source config/output.conf

#number of total experiment
n=$total
thread=10

#place holder, fill them when previous job is done
ph_min_len=PLACEHOLER_MIN_LEN
ph_phred=PLACEHOLER_PHRED

#generate script for all genome 
for a in config/genome_*.conf
do
	suffix=${a#*_}
	g_code=${suffix%.*}

	#bulild bwa_idx script for genome
	sh build/build_bwa_idx.sh ${g_code}
		
done
#generate script for all experiments
for ((i=1; i<=$n; i++ )) ;
do
	exp=exp$i
	code=${!exp}
	
	#generate fastqc script
	sh build/build_fastqc.sh $code $thread
	
	#generate trimmomatic script
	sh build/build_trimmomatic.sh $code $thread ${ph_min_len} ${ph_phred}
	
	#generate bwa_mem script
	sh build/build_bwa_mem.sh $code $thread

	#generate sam2bam script
	sh build/build_sam2bam.sh $code

	#generate bam_sort script
	sh build/build_bam_sort.sh $code

	#generate macs script
	sh build/build_macs.sh $code

done

echo "<<<<<All job scripts generated successfully."
