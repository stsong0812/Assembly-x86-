extern printf, scanf
global append

segment .data

one_integer_format db "%d", 0

segment .bss

segment .text

append:

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

; Copy the values of the first 5 registers to new registers
mov r15, rdi  ; move rdi to r15
mov r14, rsi  ; move rsi to r14
mov r13, rdx  ; move rdx to r13
mov r12, rcx  ; move rcx to r12
mov r11, r8   ; move r8 to r11

; Initialize loop1 counter to 0 and start loop1
mov r10, 0    ; initialize loop1 counter
loop1beg:     ; start of loop1
    cmp r10, r12  ; compare loop1 counter to r12
    je outLoop1   ; if they are equal, exit loop1
    movsd xmm15, [r15 + 8*r10]  ; move 8-byte value at [r15 + 8*r10] to xmm15
    movsd [r13 + 8*r10], xmm15  ; move the value in xmm15 to [r13 + 8*r10]
    inc r10     ; increment loop1 counter
    jmp loop1beg   ; jump to the start of loop1

outLoop1:   ; end of loop1

; Initialize loop2 counter to 0 and start loop2
mov r9, 0     ; initialize loop2 counter
loop2beg:     ; start of loop2
    cmp r9, r11   ; compare loop2 counter to r11
    je outLoop2   ; if they are equal, exit loop2
    movsd xmm15, [r14 + 8*r9]   ; move 8-byte value at [r14 + 8*r9] to xmm15
    movsd[r13 + 8*r10], xmm15   ; move the value in xmm15 to [r13 + 8*r10]
    inc r9      ; increment loop2 counter
    inc r10     ; increment loop1 counter (for the target index)
    jmp loop2beg   ; jump to the start of loop2

outLoop2:   ; end of loop2

mov rax, r10  ; move the value in r10 to rax (return value)

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
