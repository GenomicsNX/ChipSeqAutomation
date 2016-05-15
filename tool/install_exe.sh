#!/bin/bash
#title  install_exe.sh
#author j1angvei
#date   20160514
#usage  before analysis begin, install all necessary softwares.
#==========================================================================================

#init parameter
work=`pwd`

#import configurations
source config/directory.conf
source config/preference.conf
source config/executable.conf

#where to find all software package 
path_pkg=${work}/${dir_exe}/${dir_pkg}

#diecetory to install software
path_sw=${work}/${dir_exe}

#fastqc
unzip -o ${path_pkg}/${upk_fastqc}*.zip -d ${path_sw}
cd ${path_sw}/${upk_fastqc}
chmod 755 fastqc
cd ${work}

#bwa
tar -jxvf ${path_pkg}/${upk_bwa}.tar.bz2 -C ${path_sw}  --overwrite
cd ${path_sw}/${upk_bwa}
make
cd ${work}

#samtools
tar -jxvf ${path_pkg}/${upk_samtools}.tar.bz2 -C ${path_sw}  --overwrite
cd ${path_sw}/${upk_samtools}
make prefix=${path_sw}/${upk_samtools} install
cd ${work}

#trimmomatic
unzip -o ${path_pkg}/${upk_trim}.zip -d ${path_sw}

#macs
tar -zxvf ${path_pkg}/${upk_macs}-1.tar.gz -C ${path_sw}  --overwrite
cd ${path_sw}/${upk_macs}
$python setup.py install --prefix ${path_sw}/${upk_macs}
cd ${work}
