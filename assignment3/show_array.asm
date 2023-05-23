global show_array
extern printf

segment .data

header_line db "IEEE7554 Scientific Decimal", 10, 0
value_format db "0x%016lx%18.13e", 10, 0

segment .bss

; Empty

segment .text

; Empty

show_array:

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


push qword 0

mov r15, rdi            ; Move the value of rdi to r15
mov r14, rsi            ; Move the value of rsi to r14

push qword 0            ; Push 0 onto the stack
mov rax, 0              ; Move 0 to rax
mov rdi, header_line    ; Move the address of header_line to rdi
call printf             ; Call the printf function to print the header
pop rax                 ; Pop the value from the stack into rax

mov r13, 0              ; Initialize r13 to 0

start_Loop:
cmp r13, r14            ; Compare r13 with r14
je finish               ; Jump to finish if they are equal

push qword 0            ; Push 0 onto the stack
mov rax, 1              ; Move 1 to rax
mov rdi, value_format   ; Move the address of value_format to rdi
mov rsi, [r15 + r13*8]  ; Move the value at [r15 + r13*8] to rsi
movsd xmm0, [r15 + r13*8]   ; Move the double-precision floating-point value at [r15 + r13*8] to xmm0
call printf             ; Call the printf function to print the value
pop rax                 ; Pop the value from the stack into rax

inc r13                 ; Increment the value of r13
jmp start_Loop          ; Jump to start_Loop

finish:
pop rax                 ; Pop the value from the stack into rax

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