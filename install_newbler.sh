#/bin/bash
#Script for docker

tar -xzf /home/bin/newbler.tgz
cd /home/bin/DataAnalysis*/packages/
for file in gsSeqTools*x86_64.rpm gsNewbler*x86_64.rpm ;do rpm2cpio $file | cpio -idmv ; done
export PATH=$PATH:$PWD/opt/454/apps/mapper/bin/


