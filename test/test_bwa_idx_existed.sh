p="../output/bwa_idx/11"
if [ -e ${p}.amb -a -e ${p}.ann ]
then
        echo "genome index of ${1} already done"
        exit
else 
	echo "not exist"
fi

