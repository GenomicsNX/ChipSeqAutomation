#!/bin/bash
#title  main.sh
#author j1angvei
#date   20160412
#usage  entry of the toolkit, install software, check config, generate scripts, run jobs
#==========================================================================================

#init essential parameters
work=`pwd`

#import directory to retrieve genome files
source config/directory.conf
source config/executable.conf

#check java, python, perl, R avaliable

#remove old logs, pids, scripts
rm -f ${dir_log}/* ${dir_pid}/* ${dir_sh}/*

#accpet arguments, install all software
count_sw=`ls -l ${work}/${dir_exe} | wc -l`

#7 means a header, a package dir and fastqc, bwa, trimmomatic, samtools, MACS.
if [ ${count_sw} -lt 7 ]
then
	echo ">>>>>Start install all software, please wait..."
	sh ${work}/${dir_tool}/${sh_install_exe} >${work}/${dir_log}/install_exe.log 2>&1
	echo "<<<<<All softwares installed successfully at ${work}/${dir_exe}"
else
	echo "<<<<<All softwares already are installed, continue!"
fi

#create bakup file of config/genome.conf and store header
origin_genome=${work}/config/genome.conf
bak_genome=${origin_genome}.bak
rm -f ${bak_genome} && touch ${bak_genome}

#calculate genome size
grep -v '^$' ${origin_genome} | while read line
do
	#it is annotation line, just pass the line to bak file
	if [ ${line:0:1} = '#' ]
	then
		echo $line >> ${bak_genome}
		#skip next code if this line is only annotation
		continue
	fi

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

#write genome  bak info back into genome file and delete bak genome file
cat ${bak_genome} > ${origin_genome} && rm -f ${bak_genome}

#generate bwa idx script for all genome
grep -vE '^$|^#' config/genome.conf | while IFS=$'\t' read -r -a genomes
do
	species=${genomes[0]}
	ref=${genomes[1]}
	#generate script of create genome index using bwa
	sh build/01_bwa_idx.sh $species $ref

	#generate script of running all genome relevant scripts
	#sh build/96_start_genome.sh $species
	
done


#generate scripts from fastqc to macs for all experiments
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
	
	#generate hand qc output script
	sh build/03_qc_out.sh $code $t1 $t2 $c1 $c2

	#generate trimmomatic script, placeholder are stored in config/preference.conf
	sh build/03_trimmomatic.sh $code $t1 $t2 $c1 $c2
	
	#generate fastqc script, for already trimmed fastq file	
	sh build/04_clean_fq.sh ${code} $pe

	#generate bwa_mem script
	sh build/04_bwa_mem.sh $code $species $pe $control

	#generate sam2bam script
	sh build/05_sam2bam.sh $code $control

	#generate bam_sort script
	sh build/06_bam_sort.sh $code $control

	#generate macs script
	sh build/07_macs.sh $code $control $size

	#generate running script
	sh build/97_start_exp.sh $code	
done

#generate script to run genome scripts in order, arguments are genome codes
g_codes=`grep -vE '^$|^#' config/genome.conf|awk '{print $1}'|tr '\n' ' '`
g_codes=${g_codes% *}
sh build/98_run_genomes.sh ${g_codes}

#generate script to run experiment scripts in order, arguments are experiment codes
e_codes=`grep -vE '^$|^#' config/experiment.conf|awk '{print $1}'|tr '\n' ' '`
e_codes=${e_codes% *}
sh build/99_run_experiments.sh ${e_codes}

#output init compete info
echo "<<<<<All scripts successfully generated at ${work}/${dir_sh}"

#start running genome relevant scripts
echo "-----start genome relevant jobs"
sh ${work}/${dir_sh}/00_run_genomes.sh
echo -e "\n<<<<<All genome relevant jobs are done!"

#start running genome relevant scripts
echo "-----start experiments relevant jobs"
sh ${work}/${dir_sh}/01_run_experiments.sh
echo -e "\n<<<<<All experiment specific jobs are done!"

#output all work complet info
echo -e "\n<<<<<All jobs completed! Results in ${work}/${dir_out}."
