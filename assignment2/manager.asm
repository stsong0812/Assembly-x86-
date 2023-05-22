extern printf, scanf
extern input_array
extern Display
extern magnitude
extern append

global manager

segment .data

program_desc db "This program will manage your array of 64-bit floats",10,0

numbers_confirm db "These numbers were received and placed into array A: ",10,0
numbers_confirm_2 db "These numbers were received and placed into array B: ",10,0

array_magnitude db "The magnitude of array A is %.5lf", 10, 0
array_magnitude_2 db "The magnitude of array B is %.5lf", 10, 0

array_ab db "Arrays A and b have been appended and given the name, A ", 0xE2, 0x8A, 0x95," B", 10,0
array_ab_confirm db "A ", 0xE2, 0x8A, 0x95," B contains", 10,0

ab_magnitude db "The magnitude of A ", 0xE2, 0x8A, 0x95," B is %.5lf", 10,0

one_integer_format db "%d", 0

segment .bss
; create two arrays with size 20
array_a resq 20
array_b resq 20
; create array that is the sum of array_a and array_b sizes
appended_array resq 40

segment .text ;Reserved for executing instructions.

manager:

;Prolog ===== Insurance for any caller of this assembly module ========================================================
;Any future program calling this module that the data in the caller's GPRs will not be modified.
push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

push qword 0  ; remain on the boundary

; print "This program will manage your array of 64-bit floats"
push qword 0 ; push 0 onto the stack
mov rax, 0 ; set rax to 0
mov rdi, program_desc ; set rdi to the address of the string "program_desc"
call printf ; call the printf function to print the string at rdi
pop rax ; pop the top value from the stack into rax

;==================== ARRAY_A ====================
push qword 0
mov rax, 0 
mov rdi, array_a ; set rdi to the address of the array_a
mov rsi, 20 ; set rsi to 20 (number of elements in array_a)
call input_array ; call the input_array function to get values for array_a
mov r15, rax ; move the return value of the input_array function into r15
pop rax

push qword 0 
mov rax, 0 
mov rdi, numbers_confirm ; set rdi to the address of the string "numbers_confirm"
call printf
pop rax 

push qword 0
mov rax, 0 
mov rdi, array_a ; set rdi to the address of array_a
mov rsi, r15 ; set rsi to r15 (number of elements in array_a)
call Display ; call the Display function to print the values in array_a
pop rax 

;==================== ARRAY_A MAGNITUDE ====================

push qword 0
mov rax, 0 
mov rdi, array_a ; set rdi to the address of array_a
mov rsi, r15 ; set rsi to r15 (number of elements in array_a)
call magnitude ; call the magnitude function to calculate the magnitude of array_a
movsd xmm15, xmm0 ; move the result from xmm0 to xmm15
pop rax

push qword 0
mov rax, 1 
mov rdi, array_magnitude ; set rdi to the address of the string "array_magnitude"
movsd xmm0, xmm15 ; move the result from xmm15 to xmm0
call printf
pop rax 

;==================== ARRAY_B ====================

push qword 0
mov rax, 0 
mov rdi, array_b ; set rdi to the address of array_b
mov rsi, 20 ; set rsi to 20 (number of elements in array_b)
call input_array ; call the input_array function to get values for array_b
mov r14, rax ; move the return value of the input_array function into r14
pop rax 

push qword 0
mov rax, 0 
mov rdi, numbers_confirm_2 ; Move the address of the numbers_confirm_2 string to the rdi register
call printf
pop rax 

push qword 0 
mov rax, 0 
mov rdi, array_b ; Move the address of the array_b array to the rdi register
mov rsi, r14 ; Move the value of r14 into the rsi register
call Display ; Call the Display function to print the array
pop rax 

;==================== ARRAY_B MAGNITUDE ====================

push qword 0
mov rax, 0
mov rdi, array_b ; Move the address of the array_b array to the rdi register
mov rsi, r14 ; Move the value of r14 into the rsi register
call magnitude ; Call the magnitude function to calculate the magnitude of the array
movsd xmm15, xmm0 ; Move the value in the xmm0 register into the xmm15 register
pop rax 

push qword 0
mov rax, 1 
mov rdi, array_magnitude_2 ; Move the address of the array_magnitude_2 string to the rdi register
movsd xmm0, xmm15 ; Move the value in the xmm15 register into the xmm0 register
call printf 
pop rax 

;==================== APPENDED_ARRAY ====================

push qword 0
mov rdi, array_a ; Move array_a array to the rdi register
mov rsi, array_b ; Move array_b array to the rsi register
mov rdx, appended_array ; Move the address of the appended_array array to the rdx register
mov rcx, r15 ; Move the value of r15 into the rcx register
mov r8, r14 ; Move the value of r14 into the r8 register
call append ; Call the append function to append array_b to array_a and store the result in appended_array
mov r13, rax ; Move the return value of the append function into the r13 register
pop rax ; Pop the top value from the stack into rax

push qword 0
mov rax, 0 
mov rdi, array_ab ; Move the address of the array_ab string to the rdi register
call printf 
pop rax 

push qword 0   
mov rax, 0     
mov rdi, array_ab_confirm  ; move address of confirmation message for appended array into rdi register
call printf    
pop rax       

push qword 0  
mov rax, 0  
mov rdi, appended_array   ; move address of appended array into rdi register
mov rsi, r13   ; move the size of appended array into rsi register
call Display   ; call Display function to print the array elements
pop rax

push qword 0  
mov rax, 0    
mov rdi, appended_array   ; move address of appended array into rdi register
mov rsi, r13   ; move the size of appended array into rsi register
call magnitude ; call magnitude function to calculate the magnitude of the array
movsd xmm15, xmm0 
pop rax 

;==================== APPENDED_ARRAY MAGNITUDE ====================

push qword 0
mov rax, 1
mov rdi, ab_magnitude    ; move the address of the message for the magnitude of the appended array into rdi register
movsd xmm0, xmm15 ; move the result of magnitude calculation into xmm0 register
call printf
pop rax

pop rax ; counter push at the beginning

movsd xmm0, xmm15
;===== Restore original values to integer registers ===================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
