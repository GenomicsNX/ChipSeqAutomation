#do quality contrl for czl experiment
sh /home/jwman/chipseq-automation/script/czl_fastqc.sh 

#handle qc result of treatment data for czl experiment
/usr/java/latest/bin/java -jar  /home/jwman/chipseq-automation/output/qc/czl/T1.zip
/usr/java/latest/bin/java -jar  /home/jwman/chipseq-automation/output/qc/czl/T2.zip
tail -n +3 /home/jwman/chipseq-automation/output/qc/czl/T2.txt >> /home/jwman/chipseq-automation/output/qc/czl/T1.txt
phred=`head -n 1 /home/jwman/chipseq-automation/output/qc/czl/T1.txt`
min_len=`head -n 2 /home/jwman/chipseq-automation/output/qc/czl/T1.txt |tail -n 1`
tail -n +3 /home/jwman/chipseq-automation/output/qc/czl/T1.txt > /home/jwman/chipseq-automation/output/qc/czl/T1.fa 

#handle qc result of control data for czl experiment
/usr/java/latest/bin/java -jar  /home/jwman/chipseq-automation/output/qc/czl/C1.zip
/usr/java/latest/bin/java -jar  /home/jwman/chipseq-automation/output/qc/czl/C2.zip
tail -n +3 /home/jwman/chipseq-automation/output/qc/czl/C1.txt > /home/jwman/chipseq-automation/output/qc/czl/C1.fa 
sed -e "s/${phred}/PLACEHOLER_PHRED/g" -e "s/${min_len}/PLACEHOLER_MIN_LEN/g " /home/jwman/chipseq-automation/script/czl_trimmomatic.sh
#run trimmomatic script for experiment czl
sh /home/jwman/chipseq-automation/script/czl_trimmomatic.sh 

