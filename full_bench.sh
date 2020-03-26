SHORT_ITERS=$1
LONG_ITERS=$2
FORKCOUNT=$3
FORKSIMUL=$4

fork_1g () {
  echo "1G fork benchmarks:"
  echo "Basic fork:"
  for i in $(seq 1 $SHORT_ITERS)
  do
    ./run_test.sh basic_fork 1024 | grep "Counter"
  done

  echo ""
  echo "Basic fork (H):"
  for i in $(seq 1 $SHORT_ITERS)
  do
    ./run_test.sh basic_fork 1024 "--hugetlbmmap" | grep "Counter"
  done

  echo ""
  echo "Basic fork (G):"
  for i in $(seq 1 $SHORT_ITERS)
  do
    ./run_test.sh basic_fork 1024 "--cleargmap" | grep "Counter"
  done

  echo ""
  echo "Basic fork (HG):"
  for i in $(seq 1 $SHORT_ITERS)
  do
    ./run_test.sh basic_fork 1024 "--hugetlbmmap --cleargmap" | grep "Counter"
  done
}

fork_bench() {
  echo ""
  echo ""
  echo "Basic fork benchmarks"
  for m in 128 256 512 1024 2048 4096 6144 8192
  do
    echo "Basic fork (HG), $m MB:"
    for i in $(seq 1 $SHORT_ITERS)
    do
      ./run_test.sh basic_fork $m "--hugetlbmmap --cleargmap" | grep "Counter"
    done
  done
  for m in 128 256 512 1024 2048 4096 6144 8192
  do
    echo "Basic fork (G), $m MB:"
    for i in $(seq 1 $SHORT_ITERS)
    do
      ./run_test.sh basic_fork $m "--cleargmap" | grep "Counter"
    done
  done
}

memtest_bench() {
  echo ""
  echo "Basic memtest:"
  for i in $(seq 1 $LONG_ITERS)
  do
    ./run_test.sh basic_memtest 8192 | grep "Counter"
  done

  echo ""
  echo "Basic memtest (H):"
  for i in $(seq 1 $LONG_ITERS)
  do
    ./run_test.sh basic_memtest 8192 "--hugetlbmmap" | grep "Counter"
  done

  echo ""
  echo "Basic memtest (G):"
  for i in $(seq 1 $LONG_ITERS)
  do
    ./run_test.sh basic_memtest 8192 "--cleargmap" | grep "Counter"
  done

  echo ""
  echo "Basic memtest (HG):"
  for i in $(seq 1 $LONG_ITERS)
  do
    ./run_test.sh basic_memtest 8192 "--hugetlbmmap --cleargmap" | grep "Counter"
  done
}

java_bench() {
  echo ""
  echo "Java test (G):"
  for i in $(seq 1 $LONG_ITERS)
  do
    ./run_test.sh java 512 "--cleargmap" | grep "Counter"
  done

  echo ""
  echo "Java test (HG):"
  for i in $(seq 1 $LONG_ITERS)
  do
    ./run_test.sh java 512 "--hugetlbmmap --cleargmap" | grep "Counter"
  done
}

gcc_bench() {
  echo ""
  echo "GCC test (G):"
  for i in $(seq 1 $LONG_ITERS)
  do
    ./run_test.sh gcc 512 "--cleargmap" | grep "Counter"
  done

  echo ""
  echo "GCC test (HG):"
  for i in $(seq 1 $LONG_ITERS)
  do
    ./run_test.sh gcc 512 "--hugetlbmmap --cleargmap" | grep "Counter"
  done
}

time_tests() {
  fork_1g
  fork_bench
  memtest_bench
  java_bench
  gcc_bench
}

java_throughput() {
  echo ""
  echo "Java throughput test (G):"
  time ./run_test.sh java 512 "--cleargmap --forkmode=2 --forkcount=$FORKCOUNT --forksimul=$FORKSIMUL" | grep "Counter"

  echo ""
  echo "Java throughput test (HG):"
  time ./run_test.sh java 512 "--hugetlbmmap --cleargmap --forkmode=2 --forkcount=$FORKCOUNT --forksimul=$FORKSIMUL" | grep "Counter"

  echo ""
  echo "Java throughput test [no fork] (G):"
  time ./run_test.sh java 512 "--cleargmap --forkmode=3 --forkcount=$FORKCOUNT --forksimul=$FORKSIMUL" | grep "Counter"

  echo ""
  echo "Java throughput test [no fork] (HG):"
  time ./run_test.sh java 512 "--hugetlbmmap --cleargmap --forkmode=3 --forkcount=$FORKCOUNT --forksimul=$FORKSIMUL" | grep "Counter"
}

gcc_throughput() {
  echo ""
  echo "GCC throughput test (G):"
  time ./run_test.sh gcc 512 "--cleargmap --forkmode=2 --forkcount=$FORKCOUNT --forksimul=$FORKSIMUL" | grep "Counter"

  echo ""
  echo "GCC throughput test (HG):"
  time ./run_test.sh gcc 512 "--hugetlbmmap --cleargmap --forkmode=2 --forkcount=$FORKCOUNT --forksimul=$FORKSIMUL" | grep "Counter"

  echo ""
  echo "GCC throughput test [no fork] (G):"
  time ./run_test.sh gcc 512 "--cleargmap --forkmode=3 --forkcount=$FORKCOUNT --forksimul=$FORKSIMUL" | grep "Counter"

  echo ""
  echo "GCC throughput test [no fork] (HG):"
  time ./run_test.sh gcc 512 "--hugetlbmmap --cleargmap --forkmode=3 --forkcount=$FORKCOUNT --forksimul=$FORKSIMUL" | grep "Counter"
}


throughput_tests() {
  java_throughput
  gcc_throughput
}

time_tests
throughput_tests
