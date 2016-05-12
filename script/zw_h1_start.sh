#do quality contrl using FastQC for zw_h1 experiment
echo " `date` zw_h1 fastqc complete!" 

#handle qc output for experiment zw_h1 
sh /home/jwman/chipseq-automation/script/zw_h1_qc_out.sh > /home/jwman/chipseq-automation/log/zw_h1_qc_out.log 2>&1
echo " `date` zw_h1 qc_out complete!" 

#do trim work using trimmomatic for experiment zw_h1
echo " `date` zw_h1 trimmomatic complete!" 

