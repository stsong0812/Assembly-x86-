#include <stdbool.h>

extern int compare(const void *a, const void *b);

int compare(const void *a, const void *b)
{
    if(*(double*)a > *(double*)b)
    return 1;

    if(*(double*)a < *(double*)b)
    return -1;

    return 0;
}