
#do quality contrl using FastQC for zw_w1 experiment
echo " `date` zw_w1 fastqc complete!"

#handle qc output for experiment zw_w1 
sh /home/jwman/chipseq-automation/script/zw_w1_qc_out.sh > /home/jwman/chipseq-automation/log/zw_w1_qc_out.log 2>&1
echo " `date` zw_w1 qc_out complete!" 

#do trim work using trimmomatic for experiment zw_w1
sh /home/jwman/chipseq-automation/script/zw_w1_trimmomatic.sh > /home/jwman/chipseq-automation/log/zw_w1_trimmomatic.log 2>&1
echo " `date` zw_w1 trimmomatic complete!" 

#do alignment using bwa mem for experiment zw_w1
sh /home/jwman/chipseq-automation/script/zw_w1_bwa_mem.sh > /home/jwman/chipseq-automation/log/zw_w1_bwa_mem.log 2>&1 
echo " `date` zw_w1 bwa_mem complete!" 

#do convert sam file to bam file using samtools for experiment zw_w1
sh /home/jwman/chipseq-automation/script/zw_w1_sam2bam.sh > /home/jwman/chipseq-automation/log/zw_w1_sam2bam.log 2>&1 
echo " `date` zw_w1 sam2bam complete!" 

#do bam sort using samtools for experiment zw_w1
sh /home/jwman/chipseq-automation/script/zw_w1_bam_sort.sh > /home/jwman/chipseq-automation/log/zw_w1_bam_sort.log 2>&1
echo " `date` zw_w1 bam_sort complete!" 

#do peak calling using macs for experiment zw_w1 
export PYTHONPATH=/home/jwman/chipseq-automation/software/MACS-1.4.2/lib/python2.7/site-packages:$PYTHONPATH
export PATH=/home/jwman/chipseq-automation/software/MACS-1.4.2/bin:$PATH
sh /home/jwman/chipseq-automation/script/zw_w1_macs.sh > /home/jwman/chipseq-automation/log/zw_w1_macs.log 2>&1
echo " `date` zw_w1 macs complete!" 
