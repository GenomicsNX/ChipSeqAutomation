#do quality contrl using FastQC for czl experiment
echo " `date` czl fastqc complete!" 

#handle qc output for experiment czl 
echo " `date` czl qc_out complete!" 

#do trim work using trimmomatic for experiment czl
echo " `date` czl trimmomatic complete!" 

#do alignment using bwa mem for experiment czl
echo " `date` czl bwa_mem complete!" 

#do convert sam file to bam file using samtools for experiment czl
echo " `date` czl sam2bam complete!" 

#do bam sort using samtools for experiment czl
echo " `date` czl bam_sort complete!" 

#do peak calling using macs for experiment czl 
sh /home/jwman/chipseq-automation/script/czl_macs.sh > /home/jwman/chipseq-automation/log/czl_macs.log 2>&1
echo " `date` czl macs complete!" 

exit
