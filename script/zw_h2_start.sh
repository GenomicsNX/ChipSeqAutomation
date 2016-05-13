
#mark job start time
echo " `date` zw_h2 start analysis!"

#do quality contrl using FastQC for zw_h2 experiment
sh /home/jwman/chipseq-automation/script/zw_h2_fastqc.sh > /home/jwman/chipseq-automation/log/zw_h2_fastqc.log 2>&1
echo " `date` zw_h2 fastqc complete!"

#handle qc output for experiment zw_h2 
sh /home/jwman/chipseq-automation/script/zw_h2_qc_out.sh > /home/jwman/chipseq-automation/log/zw_h2_qc_out.log 2>&1
echo " `date` zw_h2 qc_out complete!" 

#do trim work using trimmomatic for experiment zw_h2
sh /home/jwman/chipseq-automation/script/zw_h2_trimmomatic.sh > /home/jwman/chipseq-automation/log/zw_h2_trimmomatic.log 2>&1
echo " `date` zw_h2 trimmomatic complete!" 

#do alignment using bwa mem for experiment zw_h2
sh /home/jwman/chipseq-automation/script/zw_h2_bwa_mem.sh > /home/jwman/chipseq-automation/log/zw_h2_bwa_mem.log 2>&1 
echo " `date` zw_h2 bwa_mem complete!" 

#do convert sam file to bam file using samtools for experiment zw_h2
sh /home/jwman/chipseq-automation/script/zw_h2_sam2bam.sh > /home/jwman/chipseq-automation/log/zw_h2_sam2bam.log 2>&1 
echo " `date` zw_h2 sam2bam complete!" 

#do bam sort using samtools for experiment zw_h2
sh /home/jwman/chipseq-automation/script/zw_h2_bam_sort.sh > /home/jwman/chipseq-automation/log/zw_h2_bam_sort.log 2>&1
echo " `date` zw_h2 bam_sort complete!" 

#do peak calling using macs for experiment zw_h2 
export PYTHONPATH=/home/jwman/chipseq-automation/software/MACS-1.4.2/lib/python2.7/site-packages:$PYTHONPATH
export PATH=/home/jwman/chipseq-automation/software/MACS-1.4.2/bin:$PATH
sh /home/jwman/chipseq-automation/script/zw_h2_macs.sh > /home/jwman/chipseq-automation/log/zw_h2_macs.log 2>&1
echo " `date` zw_h2 macs complete!" 
