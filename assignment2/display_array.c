//Program name: "Array Manager".
#include <stdio.h>

extern "C" void Display(double arr[], int arr_size);

// print the contents of array from the input_array module
void Display(double arr[], int arr_size) {
  for (int i = 0; i < arr_size; i++)
  {
    printf("%.5lf\n", arr[i]);
  }
}
