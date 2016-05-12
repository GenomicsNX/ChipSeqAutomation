
#do quality contrl using FastQC for zy_ck experiment
echo " `date` zy_ck fastqc complete!"

#handle qc output for experiment zy_ck 
sh /home/jwman/chipseq-automation/script/zy_ck_qc_out.sh > /home/jwman/chipseq-automation/log/zy_ck_qc_out.log 2>&1
echo " `date` zy_ck qc_out complete!" 

#do trim work using trimmomatic for experiment zy_ck
sh /home/jwman/chipseq-automation/script/zy_ck_trimmomatic.sh > /home/jwman/chipseq-automation/log/zy_ck_trimmomatic.log 2>&1
echo " `date` zy_ck trimmomatic complete!" 

#do alignment using bwa mem for experiment zy_ck
sh /home/jwman/chipseq-automation/script/zy_ck_bwa_mem.sh > /home/jwman/chipseq-automation/log/zy_ck_bwa_mem.log 2>&1 
echo " `date` zy_ck bwa_mem complete!" 

#do convert sam file to bam file using samtools for experiment zy_ck
sh /home/jwman/chipseq-automation/script/zy_ck_sam2bam.sh > /home/jwman/chipseq-automation/log/zy_ck_sam2bam.log 2>&1 
echo " `date` zy_ck sam2bam complete!" 

#do bam sort using samtools for experiment zy_ck
sh /home/jwman/chipseq-automation/script/zy_ck_bam_sort.sh > /home/jwman/chipseq-automation/log/zy_ck_bam_sort.log 2>&1
echo " `date` zy_ck bam_sort complete!" 

#do peak calling using macs for experiment zy_ck 
export PYTHONPATH=/home/jwman/chipseq-automation/software/MACS-1.4.2/lib/python2.7/site-packages:$PYTHONPATH
export PATH=/home/jwman/chipseq-automation/software/MACS-1.4.2/bin:$PATH
sh /home/jwman/chipseq-automation/script/zy_ck_macs.sh > /home/jwman/chipseq-automation/log/zy_ck_macs.log 2>&1
echo " `date` zy_ck macs complete!" 
