#include <cstdio>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern "C" double pythagoras();

int main(int argc, char* argv[])
{
  double p = 0.0;
  p = pythagoras();
  printf("The main file has received this number: %.12lf and will keep it for now\n", p);
  printf("We hope you enjoyed your complete triangle. Have a good day. A zero will be sent to your operating system\n");
  return 0;
}