
#do trimmomatic first, then do fastqc again for zw_w1 treatment
/usr/java/latest/bin/java -jar /home/jwman/chipseq-automation/software/Trimmomatic-0.36/trimmomatic-0.36.jar PE -threads 5 -phred33 /home/jwman/chipseq-automation/input/zw_w1/W1_CGATGT_L004_R1_001.fastq /home/jwman/chipseq-automation/input/zw_w1/W1_CGATGT_L004_R2_001.fastq /home/jwman/chipseq-automation/output/trim/zw_w1_t1_paired.fastq /home/jwman/chipseq-automation/output/trim/zw_w1_t1_unpaired.fastq /home/jwman/chipseq-automation/output/trim/zw_w1_t2_paired.fastq /home/jwman/chipseq-automation/output/trim/zw_w1_t2_unpaired.fastq ILLUMINACLIP:/home/jwman/chipseq-automation/output/qc/zw_w1/t_adapter.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 AVGQUAL:20 MINLEN:50 

#do trimmomatic first, then do fastqc again for zw_w1 control
