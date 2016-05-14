grep -v '^$' genome.conf | while read line
do
	if [ ${line:0:1} = '#' ]
	then
		echo "annotation $line"
		continue
	fi
	echo "info $line"

done
