# job /home/jwman/chipseq-automation/script/zw_h1_start.sh
echo "job /home/jwman/chipseq-automation/script/zw_h1_start.sh start running!"
nohup sh /home/jwman/chipseq-automation/script/zw_h1_start.sh >> /home/jwman/chipseq-automation/log/run_experiments.log 2>&1 &
echo $! >> /home/jwman/chipseq-automation/pid/run_experiments.pids 

# job /home/jwman/chipseq-automation/script/zy_ck_start.sh
echo "job /home/jwman/chipseq-automation/script/zy_ck_start.sh start running!"
nohup sh /home/jwman/chipseq-automation/script/zy_ck_start.sh >> /home/jwman/chipseq-automation/log/run_experiments.log 2>&1 &
echo $! >> /home/jwman/chipseq-automation/pid/run_experiments.pids 

#check above job status, exit when all jobs are complete
sh /home/jwman/chipseq-automation/tool/update_pids.sh /home/jwman/chipseq-automation/pid/run_experiments.pids experiments_workflow 5s
