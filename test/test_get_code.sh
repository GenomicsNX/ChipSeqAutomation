into=`grep -vE '^$|^#' experiment.conf |awk '{print $1}'| tr '\n' ' '`
into=${into% *}
echo "into $into"
sh test_parameter.sh $into
