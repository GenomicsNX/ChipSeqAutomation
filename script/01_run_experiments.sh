
#experiment czl
echo "experiment czl start analysis!"
nohup sh /home/jwman/chipseq-automation/script/czl_start.sh >> /home/jwman/chipseq-automation/log/run_experiments.log 2>&1 &
echo $! >> /home/jwman/chipseq-automation/pid/run_experiments.pids

#check above job status, exit when all jobs are complete
sh /home/jwman/chipseq-automation/tool/update_pids.sh /home/jwman/chipseq-automation/pid/run_experiments.pids 5s
