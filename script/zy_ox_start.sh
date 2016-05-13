
#mark job start time
echo " `date` zy_ox start analysis!"

#do quality contrl using FastQC for zy_ox experiment
sh /home/jwman/chipseq-automation/script/zy_ox_fastqc.sh > /home/jwman/chipseq-automation/log/zy_ox_fastqc.log 2>&1
echo " `date` zy_ox fastqc complete!"

#handle qc output for experiment zy_ox 
sh /home/jwman/chipseq-automation/script/zy_ox_qc_out.sh > /home/jwman/chipseq-automation/log/zy_ox_qc_out.log 2>&1
echo " `date` zy_ox qc_out complete!" 

#do trim work using trimmomatic for experiment zy_ox
sh /home/jwman/chipseq-automation/script/zy_ox_trimmomatic.sh > /home/jwman/chipseq-automation/log/zy_ox_trimmomatic.log 2>&1
echo " `date` zy_ox trimmomatic complete!" 

#do alignment using bwa mem for experiment zy_ox
sh /home/jwman/chipseq-automation/script/zy_ox_bwa_mem.sh > /home/jwman/chipseq-automation/log/zy_ox_bwa_mem.log 2>&1 
echo " `date` zy_ox bwa_mem complete!" 

#do convert sam file to bam file using samtools for experiment zy_ox
sh /home/jwman/chipseq-automation/script/zy_ox_sam2bam.sh > /home/jwman/chipseq-automation/log/zy_ox_sam2bam.log 2>&1 
echo " `date` zy_ox sam2bam complete!" 

#do bam sort using samtools for experiment zy_ox
sh /home/jwman/chipseq-automation/script/zy_ox_bam_sort.sh > /home/jwman/chipseq-automation/log/zy_ox_bam_sort.log 2>&1
echo " `date` zy_ox bam_sort complete!" 

#do peak calling using macs for experiment zy_ox 
export PYTHONPATH=/home/jwman/chipseq-automation/software/MACS-1.4.2/lib/python2.7/site-packages:$PYTHONPATH
export PATH=/home/jwman/chipseq-automation/software/MACS-1.4.2/bin:$PATH
sh /home/jwman/chipseq-automation/script/zy_ox_macs.sh > /home/jwman/chipseq-automation/log/zy_ox_macs.log 2>&1
echo " `date` zy_ox macs complete!" 
