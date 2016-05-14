
#do fastqc after trimmomatic for /home/jwman/chipseq-automation/output/trim/zy_ox_c1_paired.fastq
/home/jwman/chipseq-automation/software/FastQC/fastqc -o /home/jwman/chipseq-automation/output/clean -t 5 /home/jwman/chipseq-automation/output/trim/zy_ox_c1_paired.fastq

#do fastqc after trimmomatic for /home/jwman/chipseq-automation/output/trim/zy_ox_c2_paired.fastq
/home/jwman/chipseq-automation/software/FastQC/fastqc -o /home/jwman/chipseq-automation/output/clean -t 5 /home/jwman/chipseq-automation/output/trim/zy_ox_c2_paired.fastq

#do fastqc after trimmomatic for /home/jwman/chipseq-automation/output/trim/zy_ox_t1_paired.fastq
/home/jwman/chipseq-automation/software/FastQC/fastqc -o /home/jwman/chipseq-automation/output/clean -t 5 /home/jwman/chipseq-automation/output/trim/zy_ox_t1_paired.fastq

#do fastqc after trimmomatic for /home/jwman/chipseq-automation/output/trim/zy_ox_t2_paired.fastq
/home/jwman/chipseq-automation/software/FastQC/fastqc -o /home/jwman/chipseq-automation/output/clean -t 5 /home/jwman/chipseq-automation/output/trim/zy_ox_t2_paired.fastq
