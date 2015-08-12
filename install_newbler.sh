#/bin/bash
#Script for docker

cd /home/bin/
tar -xzf /home/bin/newbler.tgz
cd /home/bin/DataAnalysis*/packages/
for file in gsSeqTools*x86_64.rpm gsNewbler*x86_64.rpm ;do rpm2cpio $file | cpio -idmv ; done

