#!/bin/bash

#init essential parameters
work=`pwd`
thread=10

#place holder, fill them when previous job is done
ph_min_len=PLACEHOLER_MIN_LEN
ph_phred=PLACEHOLER_PHRED

#import directory to retrieve genome files
source config/directory.conf

#create bakup file of config/genome.conf and store header
origin_genome=${work}/config/genome.conf
bak_genome=${origin_genome}.bak
head -n 1 ${origin_genome} > ${bak_genome}

#read line of genome.conf and do calculation
grep -vE '^$|^#' ${origin_genome} | while read line
do
	#check current column numbers
	col=`echo $line |awk '{print NF}'`
	echo $col
	
	#if col==3, genome size still not add into genome.conf
	if [ $col == 3 ]
	then
		#calculate genome size 
		ref="${work}/${dir_gen}/`echo $line | awk '{print $2}' `"
		len=`wc -c $ref`
		len=${len% *}
	
		#output result to bak file
		echo -e "${line}\t${len}" >> ${bak_genome}

	#no need to add genome size, as already existed
	else 
		echo $line >> ${bak_genome}
	fi
done

#replace old genome.conf and delete genome.conf.bak
cat ${bak_genome} > ${origin_genome} && rm -rf ${bak_genome}


#generate bwa idx script for all genome
grep -vE '^$|^#' config/genome.conf | while IFS=$'\t' read -r -a genomes
do
	sh build/01_bwa_idx.sh ${genomes[0]} ${genomes[1]}
done



#generate script from fastqc to macs for all experiments
grep -vE '^$|^#' config/experiment.conf | while IFS=$'\t' read -r -a experiments
do
	code=${experiments[0]}
	species=${experiments[1]}
	t1=${experiments[2]}
	t2=${experiments[3]}
	c1=${experiments[4]}
	c2=${experiments[5]}
	
	#check if is pair end
	pe='T'
	if [ "$t2" = 'NULL' ]
	then pe='F'
	fi
	
	#check if has control
	control='T'
	if [ "$c1" = 'NULL' ]
	then control='F'
	fi

	#retrieve genome size
	size=`awk -vs="$species" '$1==s {print $4}' config/genome.conf`
	
	#generate fastqc script
	sh build/02_fastqc.sh $code $t1 $t2 $c1 $c2 $thread
	
	#generate trimmomatic script
	sh build/03_trimmomatic.sh $code $thread ${ph_min_len} ${ph_phred} $t1 $t2 $c1 $c2
	
	#generate bwa_mem script
	sh build/04_bwa_mem.sh $code $thread $species $pe $control

	#generate sam2bam script
	sh build/05_sam2bam.sh $code $control

	#generate bam_sort script
	sh build/06_bam_sort.sh $code $control

	#generate macs script
	sh build/07_macs.sh $code $control $size
	
done
#output complete info
echo -e "<<<<<All job scripts generated successfully, located at ${work}/${dir_sh}\n."
