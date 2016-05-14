
#convert /home/jwman/chipseq-automation/output/bwa_mem/zw_h2_t.sam to /home/jwman/chipseq-automation/output/sam2bam/zw_h2_t.bam 
echo "convert /home/jwman/chipseq-automation/output/bwa_mem/zw_h2_t.sam to /home/jwman/chipseq-automation/output/sam2bam/zw_h2_t.bam"
/home/jwman/chipseq-automation/software/samtools-1.3.1/bin/samtools view --threads 5 -bS /home/jwman/chipseq-automation/output/bwa_mem/zw_h2_t.sam -o /home/jwman/chipseq-automation/output/sam2bam/zw_h2_t.bam

#check alignment quality of /home/jwman/chipseq-automation/output/sam2bam/zw_h2_t.bam
echo "check alignment quality of /home/jwman/chipseq-automation/output/sam2bam/zw_h2_t.bam"
/home/jwman/chipseq-automation/software/samtools-1.3.1/bin/samtools flagstat /home/jwman/chipseq-automation/output/sam2bam/zw_h2_t.bam
