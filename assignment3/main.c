#include <stdio.h>
#include<stdlib.h>

extern char* findName();

int main()
{
    printf("Welcome to Non-Deterministic Random Numbers" "\n");
    printf("This software is maintained by Steven Song");
    printf("\n");

    const char* name = findName();

    printf("Oh, %s. We hope you enjoyed your arrays. Do come again. \n", name);
    printf("A zero will be returned to the operating system. \n");
}