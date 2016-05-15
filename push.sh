#!/bin/bash
#title  push.sh
#author j1angvei
#date   20160414
#usage  commit and push all changes to github
#==========================================================================================

#!/bin/bash
if [ $# -lt 1 ]; then
	echo 'you forgot to input commit description!'
	exit
elif [ $# -gt 1 ]; then
	echo "wrap your description with " ", like this,"your commit  description"."
	exit
else 
	git add '-A'
	git commit '-m' "$1"
	git push origin master
fi

