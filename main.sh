#!/bin/bash

#init, remove old file
#rm -rf output/*

#init essential parameters
work=`pwd`
thread=10

#place holder, fill them when previous job is done
ph_min_len=PLACEHOLER_MIN_LEN
ph_phred=PLACEHOLER_PHRED

#generate script for all genome
grep -v '^#' config/genome.conf | while IFS=$'\t' read -r -a genomes
do
	sh build/01_bwa_idx.sh ${genomes[0]} ${genomes[1]}
done

#generate script from fastqc to macs for all experiments
grep -v '^#' config/experiment.conf | while IFS=$'\t' read -r -a experiments
do
	code=${experiments[0]}
	species=${experiments[1]}
	t1=${experiments[2]}
	t2=${experiments[3]}
	c1=${experiments[4]}
	c2=${experiments[5]}

	#generate fastqc script
	sh build/02_fastqc.sh $code $t1 $t2 $c1 $c2 $thread
	
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
