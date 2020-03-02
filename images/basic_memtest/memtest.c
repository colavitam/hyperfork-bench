#include <stddef.h>
#include <strings.h>
#include <sys/mman.h>

#define SIZE (1ULL << 30)

int main(int argc, char **argv) {
  volatile long *ptr = mmap(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
  if (ptr == NULL)
    return -1;

  for (int i = 0; i < SIZE / sizeof(*ptr); i ++)
    ptr[i] = 0xDEADBEEFABCDABCD;

  return 0;
}
