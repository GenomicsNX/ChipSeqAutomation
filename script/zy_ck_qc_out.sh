
#handle treatment data for zy_ck experiment
/usr/java/latest/bin/java -jar /home/jwman/chipseq-automation/tool/fastqc-output-1.0-SNAPSHOT.jar /home/jwman/chipseq-automation/output/qc/zy_ck/CK_R1_001_fastqc.zip
tail -n +3 /home/jwman/chipseq-automation/output/qc/zy_ck/CK_R1_001_fastqc.txt > /home/jwman/chipseq-automation/output/qc/zy_ck/t_adapter.fa
/usr/java/latest/bin/java -jar /home/jwman/chipseq-automation/tool/fastqc-output-1.0-SNAPSHOT.jar /home/jwman/chipseq-automation/output/qc/zy_ck/CK_R2_001_fastqc.zip
tail -n +3 /home/jwman/chipseq-automation/output/qc/zy_ck/CK_R2_001_fastqc.txt >> /home/jwman/chipseq-automation/output/qc/zy_ck/t_adapter.fa

#handle control data for zy_ck experiment
/usr/java/latest/bin/java -jar /home/jwman/chipseq-automation/tool/fastqc-output-1.0-SNAPSHOT.jar /home/jwman/chipseq-automation/output/qc/zy_ck/CK-input_R1_001_fastqc.zip
tail -n +3 /home/jwman/chipseq-automation/output/qc/zy_ck/CK-input_R1_001_fastqc.txt >/home/jwman/chipseq-automation/output/qc/zy_ck/c_adapter.fa
/usr/java/latest/bin/java -jar /home/jwman/chipseq-automation/tool/fastqc-output-1.0-SNAPSHOT.jar /home/jwman/chipseq-automation/output/qc/zy_ck/CK-input_R2_001_fastqc.zip
tail -n +3 /home/jwman/chipseq-automation/output/qc/zy_ck/CK-input_R2_001_fastqc.txt >> /home/jwman/chipseq-automation/output/qc/zy_ck/c_adapter.fa 

#replace placeholder in /home/jwman/chipseq-automation/script/zy_ck_trimmomatic.sh
phred=`head -n 1 /home/jwman/chipseq-automation/output/qc/zy_ck/CK_R1_001_fastqc.txt`
min_len=`head -n 2 /home/jwman/chipseq-automation/output/qc/zy_ck/CK_R1_001_fastqc.txt |tail -n 1`
cat /home/jwman/chipseq-automation/script/zy_ck_trimmomatic.sh > /home/jwman/chipseq-automation/script/zy_ck_trimmomatic.sh.bak
sed -e "s/PLACEHOLDER_PHRED/${phred}/g" -e "s/PLACEHOLDER_MIN_LEN/${min_len}/g" /home/jwman/chipseq-automation/script/zy_ck_trimmomatic.sh.bak > /home/jwman/chipseq-automation/script/zy_ck_trimmomatic.sh

#remove ILLUMINACLIP parameter from trimmomaitc.sh if /home/jwman/chipseq-automation/output/qc/zy_ck/t_adapter.fa file not valid.
if [ -s /home/jwman/chipseq-automation/output/qc/zy_ck/t_adapter.fa ] 
then
	echo "there are overrepresented reads in file, no need to delete parameters from /home/jwman/chipseq-automation/script/zy_ck_trimmomatic.sh" 
else
	cat /home/jwman/chipseq-automation/script/zy_ck_trimmomatic.sh > /home/jwman/chipseq-automation/script/zy_ck_trimmomatic.sh.bak
	sed 's/ILLUMINACLIP.*t_adapter.fa:2:30:10 //g' /home/jwman/chipseq-automation/script/zy_ck_trimmomatic.sh.bak > /home/jwman/chipseq-automation/script/zy_ck_trimmomatic.sh
fi

#remove ILLUMINACLIP parameter from trimmomaitc.sh if /home/jwman/chipseq-automation/output/qc/zy_ck/c_adapter.fa file not valid.
if [ -s /home/jwman/chipseq-automation/output/qc/zy_ck/c_adapter.fa ] 
then
	echo "there are overrepresented reads in file, no need to delete parameters from /home/jwman/chipseq-automation/script/zy_ck_trimmomatic.sh" 
else
	cat /home/jwman/chipseq-automation/script/zy_ck_trimmomatic.sh > /home/jwman/chipseq-automation/script/zy_ck_trimmomatic.sh.bak
	sed 's/ILLUMINACLIP.*c_adapter.fa:2:30:10 //g' /home/jwman/chipseq-automation/script/zy_ck_trimmomatic.sh.bak > /home/jwman/chipseq-automation/script/zy_ck_trimmomatic.sh
fi

#remove trimmomatic.sh.bak file
rm -f /home/jwman/chipseq-automation/script/zy_ck_trimmomatic.sh.bak

echo ">>>>>Insert qc result into zy_ck experiment complete!" 

