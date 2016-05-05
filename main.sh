#!/bin/bash

#init essential parameters
work=`pwd`

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
	
	#if col==3, genome size still not add into genome.conf
	if [ $col == 3 ]
	then
		#calculate genome size 
		ref="${work}/${dir_gen}/`echo $line | awk '{print $2}' `"
		len=`wc -c $ref`
		len=${len% *}
	
		#output result to bak file
		echo -e "${line}\t${len}" >> ${bak_genome}

	#no need to add genome sizes, as they already existed
	else 
		echo $line >> ${bak_genome}
	fi
done

#replace old genome.conf and delete genome.conf.bak
cat ${bak_genome} > ${origin_genome} && rm -rf ${bak_genome}

#generate bwa idx script for all genome
grep -vE '^$|^#' config/genome.conf | while IFS=$'\t' read -r -a genomes
do
	species=${genomes[0]}
	ref=${genomes[1]}
	sh build/01_bwa_idx.sh $species $ref
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
	sh build/02_fastqc.sh $code $t1 $t2 $c1 $c2 
	
	#generate trimmomatic script, placeholder are stored in config/preference.conf
	sh build/03_trimmomatic.sh $code $t1 $t2 $c1 $c2
	
	#generate bwa_mem script
	sh build/04_bwa_mem.sh $code $species $pe $control

	#generate sam2bam script
	sh build/05_sam2bam.sh $code $control

	#generate bam_sort script
	sh build/06_bam_sort.sh $code $control

	#generate macs script
	sh build/07_macs.sh $code $control $size

	#generate running script
	sh build/97_run_exp.sh $code $t1 $t2 $c1 $c2	
done

exit

#generate script to run genome relevant scripts
sh build/98_run_genomes.sh "${work}/${dir_sh}/*_bwa_idx.sh"

#output init compete info
echo -e "<<<<<All job scripts generated successfully, located at ${work}/${dir_sh}\n"

#start running scripts
pids=${work}/${dir_pid}/main.pid

#output all work complet info
echo -e "<<<<<All jobs completed! You can check your results under ${work}/${dir_out}.\n"
