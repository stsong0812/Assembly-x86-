global normalize

segment .data

; Empty

segment .bss

; Empty

segment .text

normalize:

;========================= Backup GPRs ==================

push rbp                        
mov rbp, rsp
push rdi                                           ;Backup rdi
push rsi                                           ;Backup rsi
push rdx                                           ;Backup rdx
push rcx                                           ;Backup rcx
push r8                                            ;Backup r8
push r9                                            ;Backup r9
push r10                                           ;Backup r10
push r11                                           ;Backup r11
push r12                                           ;Backup r12
push r13                                           ;Backup r13
push r14                                           ;Backup r14
push r15                                           ;Backup r15
push rbx                                           ;Backup rbx
pushf                                              ;Backup rflags

;========= start the program =============

push qword 0            ;remain on the boundary

mov r15, rdi            ;r15 is the array
mov r14, rsi            ;r14 is the # of slots in array

mov r13, 0              ;r13 is the index

beginLoop:

cmp r13, r14            ;condition when the loop reach the capacity
je done

mov rdx, [r15 + 8 * r13]     ;array is copied to rdx
shl rdx, 12                  ;shift bits to the left by 12 bits in rdx
shr rdx, 12                  ;shift bits to the right by 12 bits in rdx
mov rcx, 1023                ;move the bias number into rcx
shl rcx, 52                  ;shift bits to the left by 52 bits in rcx

or rdx, rcx                 ;Bitwise OR values from rcx and rdx stored into rdx
mov [r15 + 8 * r13], rdx    ;copy the result to the array
inc r13                     ;increment r13
jmp beginLoop

done:

pop rax                 ;reverse the first push qword 

;===== Restore original values to integer registers ===============================
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

;========1=========2=========3=========4=========5=========6=========7=========8==
