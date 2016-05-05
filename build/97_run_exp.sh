#!/bin/bash
#title  97_rum_exp.sh
#author j1angvei
#date   20160505
#usage  build script to run spedified experiment scripts in order.
#==========================================================================================

#init parameter
work=`pwd`

#test if input parameters are correct
if [ $# -lt 5 ]
then
	echo "Usage: sh 99_run_exp.sh [code] [treatment 1] [treatment 2] [control 1] [control 2] "
	exit
fi

#receive passing arguments
code=$1

#import config
source config/directory.conf
source config/executable.conf
source config/preference.conf

#generate script
script=${work}/${dir_sh}/${code}_start.sh
rm -rf $script && touch $script && chmod 751 $script

#write info into script
sh_prefix=${work}/${dir_sh}/${code}_

#=====fastqc======  
echo "#do quality contrl for ${code} experiment" >> $script
echo -e "sh ${sh_prefix}fastqc.sh \n" >> $script

#=====handle qc output======
qc_prefix=${work}/${dir_out}/${qc}/${code}
t1=${qc_prefix}/${2%.*}
t2=${qc_prefix}/${3%.*}
c1=${qc_prefix}/${4%.*}
c2=${qc_prefix}/${5%.*}


echo "#handle qc result of treatment data for ${code} experiment" >> $script

#treatment 1
echo "$java -jar $jar ${t1}.zip" >> $script
#treatment 2
if [ "$3" != 'NULL' ]
then
	echo "$java -jar $jar ${t2}.zip" >> $script
	echo "tail -n +3 ${t2}.txt >> ${t1}.txt" >> $script
fi
#replace placeholder in trimmomatic.sh
echo "phred=\`head -n 1 ${t1}.txt\`" >> $script
echo "min_len=\`head -n 2 ${t1}.txt |tail -n 1\`" >> $script

#create treatment adapter.fa and fill with content
echo -e "tail -n +3 ${t1}.txt > ${t1}.fa \n" >> $script

#control 1
if [ "$4" != 'NULL' ]
then
	echo "#handle qc result of control data for ${code} experiment" >> $script
	echo "$java -jar $jar ${c1}.zip" >> $script
	#control 2
	if [ "$5" != 'NULL' ]
	then
		echo "$java -jar $jar ${c2}.zip" >> $script
	fi
	#create c_adapter.fa and fill it with content
	echo "tail -n +3 ${c1}.txt > ${c1}.fa " >> $script

fi
#replace placeholder in trimmomatic.sh
echo "sed -e \"s/\${phred}/${ph_phred}/g\" -e \"s/\${min_len}/${ph_min_len}/g \" ${sh_prefix}trimmomatic.sh" >> $script

#======trimmomatic=====
echo "#run trimmomatic script for experiment ${code}" >> $script
echo -e  "sh ${sh_prefix}trimmomatic.sh \n" >> $script

#output complete info
echo -e "=====Script generated at: ${script} \n"


