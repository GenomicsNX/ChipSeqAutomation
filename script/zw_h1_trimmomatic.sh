/usr/java/latest/bin/java -jar /home/jwman/chipseq-automation/software/Trimmomatic-0.36/trimmomatic-0.33.jar PE -thread 10 PLACEHOLER_PHRED /home/jwman/chipseq-automation/input/zw_h1/H1_ACAGTG_L004_R1_001.fastq /home/jwman/chipseq-automation/input/zw_h1/H1_ACAGTG_L004_R2_001.fastq /home/jwman/chipseq-automation/output/trim/zw_h1_t1_paired.fastq /home/jwman/chipseq-automation/output/trim/zw_h1_t1_unpaired.fastq /home/jwman/chipseq-automation/output/trim/zw_h1_t2_paired.fastq /home/jwman/chipseq-automation/output/trim/zw_h1_t2_unpaired.fastq LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 AVGQUAL:20 MINLEN:PLACEHOLER_MIN_LEN 
