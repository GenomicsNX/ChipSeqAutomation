# job /home/jwman/chipseq-automation/script/11_bwa_idx.sh
echo "job /home/jwman/chipseq-automation/script/11_bwa_idx.sh start running!"
nohup sh /home/jwman/chipseq-automation/script/11_bwa_idx.sh >> /home/jwman/chipseq-automation/log/run_genomes.log 2>&1 &
echo $! >> /home/jwman/chipseq-automation/pid/run_genomes.pids 

# job /home/jwman/chipseq-automation/script/64_bwa_idx.sh
echo "job /home/jwman/chipseq-automation/script/64_bwa_idx.sh start running!"
nohup sh /home/jwman/chipseq-automation/script/64_bwa_idx.sh >> /home/jwman/chipseq-automation/log/run_genomes.log 2>&1 &
echo $! >> /home/jwman/chipseq-automation/pid/run_genomes.pids 

#check above job status, exit when all jobs are complete
sh /home/jwman/chipseq-automation/tool/update_pids.sh /home/jwman/chipseq-automation/pid/run_genomes.pids genome_bwa_idx 5s
