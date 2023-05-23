global fill_random_array

segment .data

; Empty

segment .bss

; Empty

segment .text

; Empty

fill_random_array:

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

mov r15, rdi    ; Move the value of rdi to r15
mov r14, rsi    ; Move the value of rsi to r14
mov r13, 0      ; Initialize r13 to 0

start_Loop:     
cmp r13, r14    ; Compare r13 with r14
je finish       ; Jump to finish if they are equal

rdrand r12      ; Generate a random number and store it in r12

mov rbx, r12    ; Move the value of r12 to rbx
shr rbx, 52     ; Shift rbx right by 52 bits

cmp rbx, 0x7FF  ; Compare rbx with 0x7FF
je start_Loop   ; Jump to start_Loop if they are equal

cmp rbx, 0xFFF  ; Compare rbx with 0xFFF
je start_Loop   ; Jump to start_Loop if they are equal

mov [r15 + 8*r13], r12  ; Move the value of r12 to the memory location [r15 + 8*r13]
inc r13         ; Increment the value of r13
jmp start_Loop  ; Jump to start_Loop
finish:

mov rax, r13    ; Move the value of r13 to rax

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