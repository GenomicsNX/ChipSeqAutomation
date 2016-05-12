#do quality contrl using FastQC for zy_ck experiment
echo " `date` zy_ck fastqc complete!" 

#handle qc output for experiment zy_ck 
sh /home/jwman/chipseq-automation/script/zy_ck_qc_out.sh > /home/jwman/chipseq-automation/log/zy_ck_qc_out.log 2>&1
echo " `date` zy_ck qc_out complete!" 

#do trim work using trimmomatic for experiment zy_ck
echo " `date` zy_ck trimmomatic complete!" 

