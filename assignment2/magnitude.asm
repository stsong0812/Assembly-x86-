extern printf, scanf
global magnitude

segment .data
; empty

segment .bss
; empty

segment .text

magnitude:

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

; clear the xmm14 register
xorpd xmm14, xmm14

; move the array and array size to registers r15 and r14
mov r15, rdi ; move the address of the array (array_a) to r15
mov r14, rsi ; move the size of the array to r14

; initialize the counter
mov r13, 0

; loop through the array and square each element
beginLoop:
    cmp r14, r13 ; compare the counter to the size of the array
    je outOfLoop ; if the counter is equal to the array size, jump to the end of the loop
    movsd xmm15, [r15 + 8*r13] ; move the current element of the array to xmm15
    mulsd xmm15, xmm15 ; square the current element
    addsd xmm14, xmm15 ; add the squared element to the accumulator (xmm14)
    inc r13 ; increment the counter
    jmp beginLoop ; loop back to the beginning
outOfLoop:

; calculate the square root of the sum of squared elements
sqrtsd xmm14, xmm14 ; take the square root of the accumulated sum
movsd xmm0, xmm14 ; move the final result to the xmm0 register

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
