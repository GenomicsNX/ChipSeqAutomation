null=no_file
if [ -e $null ]
then
	echo "$null exist"
else
	echo "$null not exist"
fi

empty="empty.file"
if [ -e $empty ]
then 
	echo "$empty exist"
else
	echo "$empty not exist"
fi

content="content.file"

if [ -e $content -a -s $content ]
then
	echo 	"$content exist and not empty"
else
	echo "$content not exist or is empty"
fi

