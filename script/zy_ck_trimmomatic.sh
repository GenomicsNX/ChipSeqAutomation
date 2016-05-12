/usr/java/latest/bin/java -jar /home/jwman/chipseq-automation/software/Trimmomatic-0.36/trimmomatic-0.36.jar PE -threads 10 -phred33 /home/jwman/chipseq-automation/input/zy_ck/CK_R1_001.fastq /home/jwman/chipseq-automation/input/zy_ck/CK_R2_001.fastq /home/jwman/chipseq-automation/output/trim/zy_ck_t1_paired.fastq /home/jwman/chipseq-automation/output/trim/zy_ck_t1_unpaired.fastq /home/jwman/chipseq-automation/output/trim/zy_ck_t2_paired.fastq /home/jwman/chipseq-automation/output/trim/zy_ck_t2_unpaired.fastq LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 AVGQUAL:20 MINLEN:17 
/usr/java/latest/bin/java -jar /home/jwman/chipseq-automation/software/Trimmomatic-0.36/trimmomatic-0.36.jar PE -threads 10 -phred33 /home/jwman/chipseq-automation/input/zy_ck/CK-input_R1_001.fastq /home/jwman/chipseq-automation/input/zy_ck/CK-input_R2_001.fastq /home/jwman/chipseq-automation/output/trim/zy_ck_c1_paired.fastq /home/jwman/chipseq-automation/output/trim/zy_ck_c1_unpaired.fastq /home/jwman/chipseq-automation/output/trim/zy_ck_c2_paired.fastq /home/jwman/chipseq-automation/output/trim/zy_ck_c2_unpaired.fastq LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 AVGQUAL:20 MINLEN:17 
