for n in {1..10}
do	
	echo $n
	nohup wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000001405.33_GRCh38.p7/GCF_000001405.33_GRCh38.p7_genomic.gff.gz > sleep.log 2>&1 &
	echo $!
	sleep 3s
done
	
