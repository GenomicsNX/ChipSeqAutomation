#!/bin/bash
#title  caculate_genome_size.sh
#author j1angvei
#date   20160517
#usage  if genome size not specified, caculate them
#==========================================================================================

#check passing arguments
if [ $# -lt 2 ]; then
	echo "Usage: sh caculate_genome.sh <genome.conf> <genome directory>"
	exit
fi

#init parameter and accept arguments
work=`pwd`
conf=$1
dir=$2

#create bakup file of config/genome.conf and store header
conf_bak=${conf}.bak
rm -f ${conf_bak} && touch ${conf_bak}

#calculate genome size
grep -v '^$' ${conf} | while read line
do
        #it is annotation line, just pass the line to bak file
        if [ ${line:0:1} = '#' ]
        then
                echo $line >> ${conf_bak}
                #skip next code if this line is only annotation
                continue
        fi

        #check current column numbers
        col=`echo $line |awk '{print NF}'`

        #if col==3, genome size still not add into genome.conf
        if [ $col == 3 ]
        then
                #calculate genome size 
                ref="${dir}/`echo $line | awk '{print $2}'`"
                len=`wc -c $ref`
                len=${len% *}

                #output result to bak file
                echo -e "${line}\t${len}" >> ${conf_bak}

        #no need to add genome sizes, as they already existed
        else
                echo $line >> ${conf_bak}
        fi

done

#write bak info back to conf, and delete bak file
cat ${conf_bak} > ${conf} && rm -f ${conf_bak}
