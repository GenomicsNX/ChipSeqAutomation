#!/bin/bash
#title  03_qc_out.sh
#author j1angvei
#date   20160511
#usage  build script to retrieve qc result and set them into trimmomatic.sh script.
#==========================================================================================

#init parameter
work=`pwd`

#test if input parameters are correct
if [ $# -lt 3 ]
then
        echo "Usage: sh 03_qc_out.sh [code] [fastq R1] [fastq R2] "
        exit
fi

#import configuration
source config/executable.conf
source config/directory.conf
source config/preference.conf

#accept input parameter
code=$1
t1=$2
t2=$3

#assebmle parameters to use
in=${work}/${dir_out}/${qc}
out=${work}/${dir_out}/${dir_fa}
jar=${work}/${dir_tool}/${jar_fastqc}

#if output directory not exist, create one
if [ ! -e $out ]; then
	mkdir -p $out
fi

#generate script
script=${work}/${dir_sh}/${code}_qc_out.sh
rm -f $script && touch $script && chmod 751 $script

#deal with input data, using $jar handle zip input and generate txt output for every fastq file's qc result
for fq in $t1 $t2
do
	#fastq file not exist, skip it
	if [ "$fq" = 'F' ]; then
		continue
	fi

	#handle qc output， generate fa file and txt file
	prefix=${fq%.*}
	zip=${in}/${prefix}_fastqc.zip
	txt=${out}/${prefix}.txt

	#write command into script depends if txt file already exists.
	echo -e "\n#get qc result from $zip" >> $script
	if [ -e $txt ]; then
		echo -e "\n#result file $txt already exists, skip this one." >> $script
	else
		echo "$java -Xmx64m -jar $jar $zip $txt" >> $script
	fi
done

#create fa file store overrepresented reads
t_fa=${out}/${code}.fa
rm -f $t_fa && touch $t_fa 

#write info into t_fa
echo -e "\n#get overrepresented reads from $t1 and $t2" >> $script
#get information from $t1
echo "tail -n +3 ${out}/${t1%.*}.txt > ${t_fa}" >> $script
#get overrepresented reads from $t2
if [ "$t2" != 'F' ]; then
       	echo "tail -n +3 ${out}/${t2%.*}.txt >> ${t_fa}" >> $script
fi

#create backup file of trim script 
echo -e "\n#create ${code} bak file of trimmomatic.sh" >> $script
origin_trim=${work}/${dir_sh}/${code}_trim.sh
bak_trim=${origin_trim}.bak
echo "cat ${origin_trim} > ${bak_trim}" >> $script

#replace placeholder in trimmomatic.sh
echo -e "\n#replace placeholder in ${origin_trim}" >> $script

#get result using to replace placeholder in trimmomatic.sh
echo "phred=\`head -n 1 ${out}/${t1%.*}.txt\`" >> $script
echo "min_len=\`head -n 2 ${out}/${t1%.*}.txt |tail -n 1\`" >> $script

#echo content into script to repleace placeholder
echo "sed -e \"s/${ph_phred}/\${phred}/g\" -e \"s/${ph_min_len}/\${min_len}/g\" ${bak_trim} > ${origin_trim}" >> $script

#remove ILLUMINACLIP parameter from trimmomaitc.sh if fa file not valid.
echo -e "\n#remove ILLUMINACLIP parameter from trimmomaitc.sh if $fa file not valid." >> $script
echo -e "if [ -s "$t_fa" ]; then" >> $script
echo -e "	echo \"$t_fa not empty,do not delete ILLUMINACLIP from ${origin_trim}\" \nelse" >> $script
echo "	cat ${origin_trim} > ${bak_trim}" >> $script
echo "	sed 's/ILLUMINACLIP.*:2:30:10 //g' ${bak_trim} > ${origin_trim}" >> $script
echo "fi" >> $script

#remove trimmomatic.sh.bak
echo -e "\n#remove trimmomatic.sh.bak file" >> $script
echo "rm -f ${bak_trim}" >> $script

echo -e "\necho \">>>>>Insert qc result into ${code} experiment complete!\" \n" >> $script
