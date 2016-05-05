# job /home/jwman/chipseq-automation/script/11_bwa_idx.sh
nohup sh /home/jwman/chipseq-automation/script/11_bwa_idx.sh >> /home/jwman/chipseq-automation/log/run_genome.log 2>&1 &
echo $! >> /home/jwman/chipseq-automation/pid/run_genome.pids 

# job /home/jwman/chipseq-automation/script/64_bwa_idx.sh
nohup sh /home/jwman/chipseq-automation/script/64_bwa_idx.sh >> /home/jwman/chipseq-automation/log/run_genome.log 2>&1 &
echo $! >> /home/jwman/chipseq-automation/pid/run_genome.pids 

sh /home/jwman/chipseq-automation/tool/update_pids.sh /home/jwman/chipseq-automation/pid/run_genome.pids genome_bwa_idx
