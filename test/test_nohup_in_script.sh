#!/bin/bash
for i in {1...5}
do
nohup ls >> nohup.log 2>&1 &
echo $!>> nohup.log
done
