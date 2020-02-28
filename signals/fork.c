#include <sys/io.h>
#include <stdio.h>
#include "comm.h"

#define FORK 0x10

int main(int argc, char **argv) {
  return comm_fork();
}
