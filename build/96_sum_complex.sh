#!/bin/bash
#title 96_sum_complex.sh
#author j1angvei
#date   20160517
#usage  build one script running specific experiment's scrpts from macs to all.
#==========================================================================================

#check passing arguments
if [ $# -lt 1 ]; then
	echo "Usage: sh 96_sum_complex.sh <treat code>"
	exit
fi

#init parameter
work=`pwd`

#accept passing arguments
code=$1

#import configuration
source config/directory.conf
source config/executable.conf
source config/preference.conf

#parameter
sh_prefix=${work}/${dir_sh}/${code}
log_prefix=${work}/${dir_log}/${code}

#generate script to run complex experiments
script=${work}/${dir_sh}/${code}_complex.sh
rm -f $script && touch $script && chmod 751 $script

#=====macs======

echo -e "\n#do macs for experiment ${code}" >> $script
#add environment variable to $PATH as macs requested.
path_macs=${work}/${dir_exe}/${upk_macs}
python_v=`$python -V 2>&1`
python_v=${python_v:7:3}
echo "export PYTHONPATH=${path_macs}/lib/python${python_v}/site-packages:\$PYTHONPATH" >> $script
echo "export PATH=${path_macs}/bin:\$PATH" >> $script

#write command into script
echo "echo \" \`date\` >>>>>${code} macs START!\"" >> $script
echo "sh ${sh_prefix}_macs_wig.sh > ${log_prefix}_macs_wig.log 2>&1" >>$script
echo "echo \" \`date\` <<<<<${code} macs FINISH!\" " >> $script

#=====homer======
echo -e "\n#do annotation using homer for ${code}" >> $script
echo "echo \" \`date\` >>>>>${code} homer annotation START!\"" >> $script
echo "sh ${sh_prefix}_homer_anno.sh > ${log_prefix}_homer_anno.log 2>&1" >>$script
echo "echo \" \`date\` <<<<<${code} homer annotation FINISH!\" " >> $script

#======output complete information=====
echo "<<<<<Script generated at: $script!"
