
#do fastqc after trimmomatic for /home/jwman/chipseq-automation/output/trim/czl_*_paired.fastq
/home/jwman/chipseq-automation/software/FastQC/fastqc -o /home/jwman/chipseq-automation/output/clean -t 5 /home/jwman/chipseq-automation/output/trim/czl_*_paired.fastq