/usr/java/latest/bin/java -jar /home/jwman/ChipSeqAutomation/software/Trimmomatic-0.36/trimmomatic-0.33.jar PE -thread 10 PLACEHOLER_PHRED /home/jwman/ChipSeqAutomation/input/zw_h2/4_R1.fastq /home/jwman/ChipSeqAutomation/input/zw_h2/4_R2.fastq /home/jwman/ChipSeqAutomation/output/trim/zw_h2_t1_paired.fastq /home/jwman/ChipSeqAutomation/output/trim/zw_h2_t1_unpaired.fastq /home/jwman/ChipSeqAutomation/output/trim/zw_h2_t2_paired.fastq /home/jwman/ChipSeqAutomation/output/trim/zw_h2_t2_unpaired.fastq LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 AVGQUAL:20 MINLEN:PLACEHOLER_MIN_LEN 
