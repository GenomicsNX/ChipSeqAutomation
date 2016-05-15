
#mark job start time
echo " `date` czl start analysis!"

#do quality contrl using FastQC for czl experiment
echo " `date` >>>>>czl fastqc START!"
sh /home/jwman/chipseq-automation/script/czl_fastqc.sh > /home/jwman/chipseq-automation/log/czl_fastqc.log 2>&1
echo " `date` <<<<<czl fastqc FINISH!"

#handle qc output for experiment czl 
echo " `date` >>>>>czl qc_out START!"
sh /home/jwman/chipseq-automation/script/czl_qc_out.sh > /home/jwman/chipseq-automation/log/czl_qc_out.log 2>&1
echo " `date` <<<<<czl qc_out FINISH!" 

#do trim work using trimmomatic for experiment czl
echo " `date` >>>>>czl trimmomatic START!"
sh /home/jwman/chipseq-automation/script/czl_trimmomatic.sh > /home/jwman/chipseq-automation/log/czl_trimmomatic.log 2>&1
echo " `date` <<<<<czl trimmomatic FINISH!" 

#do fastqc using fastqc for experiment czl
echo " `date` >>>>>czl fastqc again START!"
nohup sh /home/jwman/chipseq-automation/script/czl_clean.sh >/home/jwman/chipseq-automation/log/czl_clean.log 2>&1 &
echo "`date` <<<<< fastqc again submit successfully, pid is $! "

#do alignment using bwa mem for experiment czl
echo " `date` >>>>>czl bwa mem alignment  START!"
sh /home/jwman/chipseq-automation/script/czl_bwa_mem.sh > /home/jwman/chipseq-automation/log/czl_bwa_mem.log 2>&1 
echo " `date` >>>>>czl bwa mem alignment FINISH!" 

#do convert sam file to bam file using samtools for experiment czl
echo " `date` >>>>>czl sam2bam convert START!"
sh /home/jwman/chipseq-automation/script/czl_sam2bam.sh > /home/jwman/chipseq-automation/log/czl_sam2bam.log 2>&1 
echo " `date` <<<<<czl sam2bam convert FINISH!" 

#do bam sort using samtools for experiment czl
echo " `date` >>>>>czl bam sort START!"
sh /home/jwman/chipseq-automation/script/czl_bam_sort.sh > /home/jwman/chipseq-automation/log/czl_bam_sort.log 2>&1
echo " `date` <<<<<czl bam sort FINISH!" 

#do peak calling using macs for experiment czl 
export PYTHONPATH=/home/jwman/chipseq-automation/software/MACS-1.4.2/lib/python2.7/site-packages:$PYTHONPATH
export PATH=/home/jwman/chipseq-automation/software/MACS-1.4.2/bin:$PATH
echo " `date` >>>>>czl macs START!"
sh /home/jwman/chipseq-automation/script/czl_macs.sh > /home/jwman/chipseq-automation/log/czl_macs.log 2>&1
echo " `date` <<<<<czl macs FINISH!" 
