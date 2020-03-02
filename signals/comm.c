#include <sys/io.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include "comm.h"

#define PORT 0x1234

int init_comm(void) {
  return ioperm(PORT, 8, 1);
}

void send_comm(unsigned char msg) {
  outb(msg, PORT);
}

int comm_reset(void) {
  int r;

  r = init_comm();
  if (r != 0)
    return 1;

  send_comm(RESET);

  return 0;
}

int comm_fork(void) {
  int r;

  r = init_comm();
  if (r != 0)
    return 1;

  send_comm(FORK);

  int rfd = open("/dev/random", O_RDONLY);
  int urfd = open("/dev/urandom", O_WRONLY);

  char buf[64];
  int tot = 0;
  int amt = 0;
  while (tot < 64) {
    amt = read(rfd, buf, 64);
    if (amt < 0)
      continue;

    r = write(urfd, buf, r);
    if (r < 0)
      continue;

    tot += amt;
  }

  return 0;
}

int comm_done(void) {
  int r;

  r = init_comm();
  if (r != 0)
    return 1;

  send_comm(DONE);

  return 0;
}
