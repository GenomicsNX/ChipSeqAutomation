number=$#
echo "parameter number is $number"
echo -e "direct\n$1 $2 \nindirect"
for n in $(seq 1 $number)
do
eval code=\$$n
echo $code
done

