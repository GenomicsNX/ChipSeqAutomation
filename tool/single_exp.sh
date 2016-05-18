#!/bin/bash
#title  single_experiment.sh
#author j1angvei
#date   20160517
#usage  build one script including all specific scripts running from fastqc to bam sort
#==========================================================================================

#check passing arguments
if [ $# -lt 2 ]; then
        echo "Usage: sh caculate_genome.sh <experiment.conf> <build directory>"
        exit
fi

#init parameter and accept arguments
work=`pwd`
conf=$1
dir=$2

#generate scripts from fastqc to bam sort for all single experiments
grep -vE '^$|^#' ${conf} | while IFS=$'\t' read -r -a exp
do
        code=${exp[0]}
        species=${exp[1]}
        R1=${exp[2]}
        R2=${exp[3]}

        #check if is pair end
        pe='T'
        if [ "$R2" = 'F' ]; then
        	pe='F'
        fi

        #retrieve genome size
        #size=`awk -vs="$species" '$1==s {print $4}' config/genome.conf`

        #generate fastqc script
        sh ${dir}/02_fastqc.sh $code $R1 $R2

        #generate hand qc output script
        sh ${dir}/03_qc_out.sh $code $R1 $R2

        #generate trimmomatic script, placeholder are stored in config/preference.conf
        sh ${dir}/04_trim.sh $code $R1 $R2

        #generate fastqc script, for already trimmed fastq file 
        sh ${dir}/05_clean_fq.sh ${code} $pe

        #generate bwa_mem script
        sh ${dir}/06_bwa_mem.sh $code $species $pe

        #generate sam2bam script
        sh ${dir}/07_sam_bam.sh $code $pe

        #generate bam_sort script
        sh ${dir}/08_bam_sort.sh $code $pe

	#generate qualimap script
	sh ${dir}/10_qualimap.sh ${code}

	#generate sum up script
	sh ${dir}/95_sum_single.sh ${code}

done

#output complete info
echo ">>>>>Script assemble successfully using tool \"single_exp.sh\""
