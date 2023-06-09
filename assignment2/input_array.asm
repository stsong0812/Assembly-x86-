extern printf, scanf
extern stdin
extern clearerr

global input_array

segment .data

enter_prompt db "For array A enter a sequence of 64-bit floats separated by white space.", 10, 0
enter_prompt_two db "After the last input press enter followed by Control+D:", 10, 0
float_format db "%lf", 0

segment .bss  ;Reserved for uninitialized data

segment .text ;Reserved for executing instructions.

input_array:

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

push qword 0 ;staying on the boundary

; Store the array and array size
mov r15, rdi  ; move the array address to r15
mov r14, rsi  ; move the array size to r14

; Print the first prompt
push qword 0
mov rax, 0
mov rdi, enter_prompt
call printf
pop rax

; Print the second prompt
push qword 0
mov rax, 0
mov rdi, enter_prompt_two
call printf
pop rax

mov r13, 0  ; initialize a counter to 0

; Loop for user input until control+D is pressed
beginLoop:  ; start of loop
  cmp r14, r13  ; compare array size with counter
  je outOfLoop  ; if they are equal, exit the loop
  mov rax, 0
  mov rdi, float_format
  push qword 0
  mov rsi, rsp
  call scanf   ; read a float value from the user input
  cdqe   ; convert to 8-byte value
  cmp rax, -1   ; terminate loop when control+D is pressed
  pop r12
  je outOfLoop  ; jump to the end of the loop
  mov [r15 + 8*r13], r12  ; move the float value to the array
  inc r13  ; increment the counter
  jmp beginLoop  ; jump to the start of the loop

outOfLoop:  ; end of loop

; Clear the failbit
mov rax, 0
mov rdi, [stdin]
call clearerr

pop rax  ; pop the counter push at the beginning of the code
mov rax, r13  ; move the value of the counter to rax (return value)
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
