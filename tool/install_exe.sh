work=`pwd`
source config/directory.conf
source config/preference.conf
#install macs needs python
source config/executable.conf

path_pkg=${work}/${dir_exe}/${dir_pkg}
path_sw=${work}/${dir_exe}

#fastqc
unzip -o ${path_pkg}/${upk_fastqc}*.zip -d ${path_sw}
cd ${path_sw}/${upk_fastqc}
chmod 755 fastqc
cd ${work}
exit
#bwa
tar -jxvf ${path_pkg}/${upk_bwa}.tar.bz2 -C ${path_sw}  --overwrite
cd ${path_sw}/${upk_bwa}
make
cd ${work}

#samtools
tar -jxvf ${path_pkg}/${upk_samtools}.tar.bz2 -C ${path_sw}  --overwrite
cd ${path_sw}/${upk_samtools}
make
cd ${work}

#trimmomatic
unzip -o ${path_pkg}/${upk_trim}.zip -d ${path_sw}

#macs
tar -zxvf ${path_pkg}/${upk_macs}.tar.gz -d ${path_sw}  --overwrite
cd ${path_sw}/${upk_macs}
$python setup.py install --prefix ${path_sw}/${upk_macs}
cd ${work}
