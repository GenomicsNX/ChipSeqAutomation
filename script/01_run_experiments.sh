
#experiment czl
echo "experiment czl start analysis!"
nohup sh /home/jwman/chipseq-automation/script/czl_start.sh >> /home/jwman/chipseq-automation/log/run_experiments.log 2>&1 &
echo $! >> /home/jwman/chipseq-automation/pid/run_experiments.pids

#experiment zw_h1
echo "experiment zw_h1 start analysis!"
nohup sh /home/jwman/chipseq-automation/script/zw_h1_start.sh >> /home/jwman/chipseq-automation/log/run_experiments.log 2>&1 &
echo $! >> /home/jwman/chipseq-automation/pid/run_experiments.pids

#experiment zw_h2
echo "experiment zw_h2 start analysis!"
nohup sh /home/jwman/chipseq-automation/script/zw_h2_start.sh >> /home/jwman/chipseq-automation/log/run_experiments.log 2>&1 &
echo $! >> /home/jwman/chipseq-automation/pid/run_experiments.pids

#experiment zw_w1
echo "experiment zw_w1 start analysis!"
nohup sh /home/jwman/chipseq-automation/script/zw_w1_start.sh >> /home/jwman/chipseq-automation/log/run_experiments.log 2>&1 &
echo $! >> /home/jwman/chipseq-automation/pid/run_experiments.pids

#experiment zw_w2
echo "experiment zw_w2 start analysis!"
nohup sh /home/jwman/chipseq-automation/script/zw_w2_start.sh >> /home/jwman/chipseq-automation/log/run_experiments.log 2>&1 &
echo $! >> /home/jwman/chipseq-automation/pid/run_experiments.pids

#experiment zy_ck
echo "experiment zy_ck start analysis!"
nohup sh /home/jwman/chipseq-automation/script/zy_ck_start.sh >> /home/jwman/chipseq-automation/log/run_experiments.log 2>&1 &
echo $! >> /home/jwman/chipseq-automation/pid/run_experiments.pids

#experiment zy_ox
echo "experiment zy_ox start analysis!"
nohup sh /home/jwman/chipseq-automation/script/zy_ox_start.sh >> /home/jwman/chipseq-automation/log/run_experiments.log 2>&1 &
echo $! >> /home/jwman/chipseq-automation/pid/run_experiments.pids

#check above job status, exit when all jobs are complete
sh /home/jwman/chipseq-automation/tool/update_pids.sh /home/jwman/chipseq-automation/pid/run_experiments.pids 5s
