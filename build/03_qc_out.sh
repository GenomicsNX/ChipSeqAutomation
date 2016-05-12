#!/bin/bash
#title  03_qc_out.sh
#author j1angvei
#date   20160511
#usage  build script to retrieve qc result and set them into trimmomatic.sh script.
#==========================================================================================

#init parameter
work=`pwd`

#test if input parameters are correct
if [ $# -lt 5 ]
then
        echo "Usage: sh 03_qc_out.sh [code] [treatment 1] [treatment 2] [control 1] [control 2] "
        exit
fi

#import configuration
source config/executable.conf
source config/directory.conf
source config/preference.conf

#accept input parameter
code=$1
qc_prefix=${work}/${dir_out}/${qc}/${code}
sh_prefix=${work}/${dir_sh}/${code}
jar=${work}/${dir_tool}/${jar_fastqc}

#assemble commom file name prefix(absolute path), such as *fastqc.zip, *fastqc.txt,*fastqc.fa
t1=${qc_prefix}/${2%.*}_fastqc
t2=${qc_prefix}/${3%.*}_fastqc
c1=${qc_prefix}/${4%.*}_fastqc
c2=${qc_prefix}/${5%.*}_fastqc

#create file to store overrepresented reads info
t_fa=${qc_prefix}/t_adapter.fa
c_fa=${qc_prefix}/c_adapter.fa
rm -f ${t_fa} ${c_fa} && touch ${t_fa} ${c_fa}

#generate script
script=${work}/${dir_sh}/${code}_qc_out.sh
rm -f $script && touch $script && chmod 751 $script

#write info into script
echo -e "\n#handle treatment data for ${code} experiment" >> $script

#get info from treatment 1
echo "$java -jar $jar ${t1}.zip" >> $script
echo -e "tail -n +3 ${t1}.txt > ${t_fa}" >> $script

#get info from treatment 2
if [ "$3" != 'NULL' ]
then
        echo "$java -jar $jar ${t2}.zip" >> $script
        echo "tail -n +3 ${t2}.txt >> ${t_fa}" >> $script
fi

#get info from control 1
if [ "$4" != 'NULL' ]
then
        echo -e "\n#handle control data for ${code} experiment" >> $script
        echo "$java -jar $jar ${c1}.zip" >> $script
	echo "tail -n +3 ${c1}.txt >${c_fa}" >> $script
#get info from control 2
        if [ "$5" != 'NULL' ]
        then
                echo "$java -jar $jar ${c2}.zip" >> $script
		echo -e "tail -n +3 ${c2}.txt >> ${c_fa} " >> $script
        fi

fi

#replace placeholder in trimmomatic.sh
echo -e "\n#replace placeholder in ${sh_prefix}_trimmomatic.sh" >> $script

#get result using to replace placeholder in trimmomatic.sh
echo "phred=\`head -n 1 ${t1}.txt\`" >> $script
echo "min_len=\`head -n 2 ${t1}.txt |tail -n 1\`" >> $script

#create backup file of trim script 
origin_trim=${sh_prefix}_trimmomatic.sh
bak_trim=${sh_prefix}_trimmomatic.sh.bak
echo "cat ${origin_trim} > ${bak_trim}" >> $script

#echo content into script to repleace placeholder
echo "sed -e \"s/${ph_phred}/\${phred}/g\" -e \"s/${ph_min_len}/\${min_len}/g\" ${bak_trim} > ${origin_trim}" >> $script

#remove ILLUMINACLIP parameter from trimmomaitc.sh if fa file not valid.
for fa in ${t_fa} ${c_fa}
do
	echo -e "\n#remove ILLUMINACLIP parameter from trimmomaitc.sh if $fa file not valid." >> $script
	echo -e "if [ -s "$fa" ] \nthen" >> $script
	echo -e "	echo \"there are overrepresented reads in file, no need to delete parameters from ${origin_trim}\" \nelse" >> $script
	echo "	cat ${origin_trim} > ${bak_trim}" >> $script
	echo "	sed 's/ILLUMINACLIP.*${fa##*/}:2:30:10 //g' ${bak_trim} > ${origin_trim}" >> $script
	echo "fi" >> $script
done

#remove trimmomatic.sh.bak
echo -e "\n#remove trimmomatic.sh.bak file" >> $script
echo "rm -f ${bak_trim}" >> $script

echo -e "\necho \">>>>>Insert qc result into ${code} experiment complete!\" \n" >> $script

