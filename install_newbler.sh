#/bin/bash
#Script for docker

tar -xzf newbler.tgz
cd DataAnalysis*/packages/
for file in gsSeqTools*.rpm gsNewbler*.rpm ;do rpm2cpio $file | cpio -idmv ; done
export PATH=$PATH:$PWD/opt/454/apps/mapper/bin/


