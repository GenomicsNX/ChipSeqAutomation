for n in {1..10}
do
	nohup wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000001405.33_GRCh38.p7/GCF_000001405.33_GRCh38.p7_genomic.gff.gz  >> wget.log 2>&1&
	pid=$!
	echo $pid >> test.pid
	echo $pid
done
