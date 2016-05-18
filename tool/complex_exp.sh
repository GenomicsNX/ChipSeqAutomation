#!/bin/bash
#title  complex_exp.sh
#author j1angvei
#date   20160518
#usage  build one script generating all specific scripts of specidic experiment
#==========================================================================================

#check passing arguments
if [ $# -lt 3 ]; then
        echo "Usage: sh caculate_genome.sh <experiment.conf> <genome.conf> <build directory>"
        exit
fi

#init parameter and accept arguments
work=`pwd`
exp_conf=$1
gen_conf=$2
bd_dir=$3

#generate scripts from fastqc to bam sort for all single experiments
grep -vE '^$|^#' ${exp_conf} | while IFS=$'\t' read -r -a exp
do
        treat=${exp[0]}
        species=${exp[1]}
        control=${exp[4]}

        #if current experiment is a control data, skip it
        if [ $treat = $control ]; then
        	continue
        fi
	
	#check if pair end  or single end
	pe='T'
	if [ $control = 'F' ]; then
		pe='F'
	fi

        #retrieve genome size 
      	g_size=`awk -vs="$species" '$1==s {print $4}' ${gen_conf}`
	
	#get file name of reference genome and annotation
	gen_line=`grep "^${species} " ${gen_conf}`
	ref=`echo ${gen_line}|awk '{print $2}'`
	anno=`echo ${gen_line}|awk '{print $3}'`

	#do macs 
	sh ${bd_dir}/09_macs_wig.sh $pe ${treat} ${control} ${g_size}
	
	#do homer
	sh ${bd_dir}/11_homer_anno.sh ${treat} ${ref} ${anno}

	#do GO and pathway analysis

	#generate script to assemble all generated scripts
	sh ${bd_dir}/96_sum_complex.sh ${treat}

done

#output complete information
echo ">>>>>Scripts assebmle successfully using tool \"complex_exp.sh!\""
