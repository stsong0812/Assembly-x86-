//****************************************************************************************************************************
//Program name: "Array Manager".
// This program will allow a user to input float numbers in an array of size 6, and display the contents. It will also add
// them together and display the result.
// Copyright (C) 2023 Steven Song.                                                                           
//                                                                                                                           
//This file is part of the software program "Array Manager".
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   
//version 3 as published by the Free Software Foundation.                                                                    
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY// without even the implied          
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                            
//****************************************************************************************************************************

//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//  Author name: Steven Song
//  Author email: stsong0812@csu.fullerton.edu
//
//Program information
//  Program name: Array Manager
//  Programming languages: Assembly, C++, C, bash
//  Date program began: 2023 February 10
//  Date of last update: 2021 February 21
//  Files in this program: run.sh, append.asm, input_array.asm, magnitude.asm, manager.asm, main.c, display_array.c
//  Status: Finished.
//
//This file
//   File name: main.c
//   Language: C
//   Compile: gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c17
//   Link: g++ -m64 -no-pie -o addFloatArray.out manager.o input_array.o main.o magnitude.o append.o display_array.o -std=c++17
//   Purpose: This is the driver module that will call manager() to initialize the array operations.
//========================================================================================================

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