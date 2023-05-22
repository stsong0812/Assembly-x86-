#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern double manager(); 

int main(int argc, char *argv[])
{
  // print program welcome message
  printf("Welcome to Array Manager.\n"
         "Programmed by: Steven Song\n");

  // print the value passed in from manager module
  double answer = manager();
  printf("The main has received this number %.10lf and will keep it.\n", answer);
  printf("Thank you for using Array Manager.\n"
          "A zero will be returned to the operating system.\n"
          "Have a good day!\n");
}
