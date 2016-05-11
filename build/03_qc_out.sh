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
sh_prefix=${work}/${dir_sh}/${code}_
jar=${work}/${dir_tool}/${jar_fastqc}

#assemble commom file name prefix(absolute path), such as *fastqc.zip, *fastqc.txt,*fastqc.fa
t1=${qc_prefix}/${2%.*}_fastqc
t2=${qc_prefix}/${3%.*}_fastqc
c1=${qc_prefix}/${4%.*}_fastqc
c2=${qc_prefix}/${5%.*}_fastqc

#generate script
script=${work}/${dir_sh}/${code}_qc_out.sh
rm -f $script && touch $script && chmod 751 $script

#write info into script
echo "#handle treatment data for ${code} experiment" >> $script

#treatment 1
echo "$java -jar $jar ${t1}.zip" >> $script
#treatment 2
if [ "$3" != 'NULL' ]
then
        echo "$java -jar $jar ${t2}.zip" >> $script
        echo "tail -n +3 ${t2}.txt >> ${t1}.txt" >> $script
fi
#get result using to replace placeholder in trimmomatic.sh
echo "phred=\`head -n 1 ${t1}.txt\`" >> $script
echo "min_len=\`head -n 2 ${t1}.txt |tail -n 1\`" >> $script

#create treatment adapter.fa and fill with content
echo -e "tail -n +3 ${t1}.txt > ${t1}.fa \n" >> $script

#control 1
if [ "$4" != 'NULL' ]
then
        echo "#handle control data for ${code} experiment" >> $script
        echo "$java -jar $jar ${c1}.zip" >> $script
        #control 2
        if [ "$5" != 'NULL' ]
        then
                echo "$java -jar $jar ${c2}.zip" >> $script
        fi
        #create c_adapter.fa and fill it with content
        echo -e "tail -n +3 ${c1}.txt > ${c1}.fa \n " >> $script

fi
#replace placeholder in trimmomatic.sh
echo "#replace placeholder in ${sh_prefix}trimmomatic.sh" >> $script

#create backup file of trim script 
origin_trim=${sh_prefix}trimmomatic.sh
bak_trim=${sh_prefix}trimmomatic.sh.bak
echo "cat ${origin_trim} > ${bak_trim}" >> $script

#echo content into script
echo -e "sed -e \"s/${ph_phred}/\${phred}/g\" -e \"s/${ph_min_len}/\${min_len}/g\" ${bak_trim} > ${origin_trim} \n" >> $script

#remove ILLUMINACLIP parameter from trimmomaitc.sh if fa file not valid.
for fa in ${t1}.fa ${c1}.fa
do
	echo "#remove ILLUMINACLIP parameter from trimmomaitc.sh if $fa file not valid." >> $script
	echo -e "if ! [ -e "$fa" -a -s "$fa" ] \nthen" >> $script
	echo "	cat ${origin_trim} > ${bak_trim}" >> $script
	echo "	sed 's/ILLUMINACLIP.*:2:30:10 //g' ${bak_trim} > ${origin_trim}" >> $script
	echo -e "fi\n" >> $script
done

#remove trimmomatic.sh.bak
echo "#remove trimmomatic.sh.bak file" >> $script
echo "rm -f ${bak_trim}" >> $script

echo -e "echo \">>>>>Insert qc result into ${code} experiment complete!\" \n" >> $script

