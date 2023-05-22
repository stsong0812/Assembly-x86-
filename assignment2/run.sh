#!/bin/bash

#Program: Adding Float Array
#Author: Johnson Tong

#Purpose: script file to run the program files together.
#Clear any previously compiled outputs
rm *.o
rm *.out
rm *.lis

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "compile fill.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "compile magnitude.asm"
nasm -f elf64 -l magnitude.lis -o magnitude.o magnitude.asm

echo "compile append.asm"
nasm -f elf64 -l append.lis -o append.o append.asm

echo "compile display_array.c using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o display_array.o display_array.c

echo "compile main.c using gcc compiler standard 2017"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c17

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -o addFloatArray.out manager.o input_array.o main.o magnitude.o append.o display_array.o -std=c++17

echo "Run the Add Float Array Program:"
./addFloatArray.out

echo "Script file has terminated."

#Clean up after program is run
rm *.o
rm *.out
rm *.lis
