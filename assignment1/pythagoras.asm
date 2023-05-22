extern printf, scanf
global pythagoras

segment .data

; intro statements
welcome db "Welcome to 'Hypotenuse Calculator' by Steven Song", 10, 0
description db "The purpose of this program is to calculate the hypotenuse of a triangle given two sides", 10, 0
contact db "Please contact me at StevenSong082@gmail.com if you need assistance", 10, 0

; prompts
prompt1 db "Enter the length of the first side of the triangle: ", 0
prompt2 db "Enter the length of the second side of the triangle: ", 0

; long float statement
double_form db "%lf",0

; calculation output statements
confirm db "Thank you. You entered two sides: %1.6lf and %1.6lf ", 10, 0 
hypotenuse db "The length of the hypotenuse is %1.6lf", 10, 0

segment .bss
; empty segment

segment .text

pythagoras:
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

; beginning push qword 0
push qword 0

; print welcome statement to terminal
mov rax, 0
mov rdi, welcome
call printf

; print description statement to terminal
mov rax, 0
mov rdi, description
call printf

; print contact information to terminal
mov rax, 0 
mov rdi, contact
call printf

; prompt user for first side
mov rax, 0
mov rdi, prompt1
call printf

; store first side in xmm10
push qword 0
mov rax, 0
mov rdi, double_form ; 
mov rsi, rsp 
call scanf
movsd xmm10, [rsp]
pop rax

; prompt user for second side
push qword 0
mov rax, 0
mov rdi, prompt2        
call printf
pop rax

; store second side in xmm11
push qword 0
mov rax, 0
mov rdi, double_form
mov rsi, rsp
call scanf
movsd xmm11, [rsp]
pop rax

; print confirmation of two sides
push qword 0
mov rax, 2
mov rdi, confirm
movsd xmm0, xmm10
movsd xmm1, xmm11    
call printf
pop rax

; square first side, store in same place
mulsd xmm10, xmm10

; square second side, store in same place
mulsd xmm11, xmm11

; add first and second side, store back in xmm11
addsd xmm11, xmm10

; square root sum of both sides and store in xmm12
sqrtsd xmm12, xmm11

; print hypotenuse of triangle
push qword 0
mov rax, 1
mov rdi, hypotenuse
movsd xmm0, xmm12
call printf
pop rax

; final pop rax
pop rax

; return value to driver
movsd xmm0, xmm12

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