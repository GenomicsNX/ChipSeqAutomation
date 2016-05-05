#do quality contrl for zw_w1 experiment
sh /home/jwman/chipseq-automation/script/zw_w1_fastqc.sh 

#handle qc result of treatment data for zw_w1 experiment
/usr/java/latest/bin/java -jar  /home/jwman/chipseq-automation/output/qc/zw_w1/W1_CGATGT_L004_R1_001.zip
/usr/java/latest/bin/java -jar  /home/jwman/chipseq-automation/output/qc/zw_w1/W1_CGATGT_L004_R2_001.zip
tail -n +3 /home/jwman/chipseq-automation/output/qc/zw_w1/W1_CGATGT_L004_R2_001.txt >> /home/jwman/chipseq-automation/output/qc/zw_w1/W1_CGATGT_L004_R1_001.txt
phred=`head -n 1 /home/jwman/chipseq-automation/output/qc/zw_w1/W1_CGATGT_L004_R1_001.txt`
min_len=`head -n 2 /home/jwman/chipseq-automation/output/qc/zw_w1/W1_CGATGT_L004_R1_001.txt |tail -n 1`
tail -n +3 /home/jwman/chipseq-automation/output/qc/zw_w1/W1_CGATGT_L004_R1_001.txt > /home/jwman/chipseq-automation/output/qc/zw_w1/W1_CGATGT_L004_R1_001.fa 

sed -e "s/${phred}/PLACEHOLER_PHRED/g" -e "s/${min_len}/PLACEHOLER_MIN_LEN/g " /home/jwman/chipseq-automation/script/zw_w1_trimmomatic.sh
#run trimmomatic script for experiment zw_w1
sh /home/jwman/chipseq-automation/script/zw_w1_trimmomatic.sh 

