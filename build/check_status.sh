#!/bin/bash
source ./pid.log
key=${$1}
echo $key
echo `ps -p $key` 
