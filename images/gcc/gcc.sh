#!/bin/busybox sh
cd /prog
export GCC_EXEC_PREFIX=/usr/libexec/gcc/
export LIBRARY_PATH=/usr/lib/gcc/x86_64-alpine-linux-musl/6.4.0
/reset
g++ -c mvn.cc
/reset
/done
