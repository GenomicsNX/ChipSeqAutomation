#!/bin/bash
if [ $# -lt 1 ]; then
	echo 'you forgot to input commit description!'
	exit
elif [ $# -gt 1 ]; then
	echo 'wrap your description with '', like this,'your-description'.'
	exit
else 
	git add '-A'
	git commit '-m' $1
	git push origin master
fi

