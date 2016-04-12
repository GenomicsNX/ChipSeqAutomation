#!/bin/bash
source ./input.conf
code=$exp
echo $exp
prefix=${code//,/ }
echo $code
for line in `echo $prefix`
do
 echo $line
done
