#!/bin/bash
cd /spark/spark-2.4.5-bin-hadoop2.7
export JAVA_HOME=/usr/local/openjdk-8
mount -t proc proc /proc
ln -s /proc/self/fd /dev/fd
mv /etc/hostsc /etc/hosts
ip link set lo up
./bin/spark-submit /pi.py 4
