grep -vE '^$|^#' ../config/genome.conf | while read line
do
	echo $line | awk '{print $1}'
done

