file="file32_exist.txt"
if ! [ -e $file -a -s $file ]
then
echo "file not exist"
fi

touch $file

if ! [ -e $file -a -s $file ]
then 
echo "file is empty"
fi

echo "info" >$file

if ! [ -e $file -a -s $file ]
then
echo "file is empty"
else
echo "file not empty"
fi

 
