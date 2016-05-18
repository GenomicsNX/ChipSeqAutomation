#!/bin/bash
#title  main.sh
#author j1angvei
#date   20160412
#usage  entry of the toolkit, install software, check config, generate scripts, run jobs
#==========================================================================================

#echo start time
echo "`date` 	Start Analysis using ChIP-Seq Automation by j1angvei......"

#init essential parameters
work=`pwd`

#import directory to retrieve genome files
source config/directory.conf
source config/executable.conf

#check java, python, perl, R avaliable

#remove old logs, pids, scripts
rm -f ${dir_log}/*.log ${dir_pid}/* ${dir_sh}/*

#=====install softwares=====
#check if all softare are installed.
count_sw=`ls -l ${work}/${dir_exe} | wc -l`

#7 means a header, a package dir and fastqc, bwa, trimmomatic, samtools, MACS.
if [ ${count_sw} -lt 8 ]
then
	echo "-----Start install all software, please wait..."
	sh ${work}/${dir_tool}/${sh_install_exe} >${work}/${dir_log}/install_exe.log 2>&1
	echo "<<<<<All softwares installed successfully at ${work}/${dir_exe}"
else
	echo "<<<<<All softwares already are installed, continue!"
fi

#=====caculate genome size=====
sh ${work}/${dir_tool}/${sh_calculate_genome} ${work}/config/genome.conf ${work}/${dir_genome}

#=====build genome index scripts=====
grep -vE '^$|^#' config/genome.conf | while IFS=$'\t' read -r -a genomes
do
	species=${genomes[0]}
	ref=${genomes[1]}
	#generate script of create genome index using bwa
	sh build/01_bwa_idx.sh $species $ref
done

#=====build single experiment script, from fastqc to bam_sort=====
sh ${dir_tool}/${sh_single_exp} ${work}/config/experiment.conf ${work}/${dir_bd}
	
#=====build complex experiment script, from macs to further=====
sh ${dir_tool}/${sh_complex_exp} ${work}/config/experiment.conf  ${work}/config/genome.conf ${work}/${dir_bd}

#=====build script running genome scripts=====
g_codes=`grep -vE '^$|^#' config/genome.conf|awk '{print $1}'|tr '\n' ' '`
g_codes=${g_codes% *}
sh build/97_run_genomes.sh ${g_codes}

#=====build script running single experiments======
e_codes=`grep -vE '^$|^#' config/experiment.conf|awk '{print $1}'|tr '\n' ' '`
e_codes=${e_codes% *}
sh build/98_run_singles.sh ${e_codes}
sh build/99_run_complexes.sh ${e_codes}

#output init compete info
echo "<<<<<All scripts successfully generated at ${work}/${dir_sh}"

#=====start running genome=====
exit
start running genome relevant scripts
echo "-----start genome jobs"
sh ${work}/${dir_sh}/00_run_genomes.sh
echo -e "\n<<<<<All genome jobs are done!"

#start running single exp relevant scripts
echo "-----start single experiment jobs"
sh ${work}/${dir_sh}/01_run_singles.sh
echo -e "\n<<<<<All single experiment jobs are done!"

#start running single exp relevant scripts
echo "-----start complex experiment relevant jobs"
sh ${work}/${dir_sh}/02_run_complexes.sh
echo -e "\n<<<<<All complex experiment jobs are done!"

#output all work complet info
echo -e "\n<<<<<All jobs completed! Results in ${work}/${dir_out}."
