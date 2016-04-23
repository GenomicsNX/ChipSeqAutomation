phred=`head -n 1 fastqc_jar.text`
echo "phred $phred"
min_len=`head -n 2 fastqc_jar.text|tail -n 1 `
echo "min len $min_len"
file=fastqc.fa
rm -rf $file && touch $file
tail -n +3 fastqc_jar.text  > $file
