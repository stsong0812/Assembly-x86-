extern normalize
extern printf, scanf
extern show_array
extern fill_random_array
extern stdin
extern strlen
extern fgets
extern qsort
extern compare

input_length equ 256

global findName

segment .data

	input_name db "Please Enter your name: ", 0
    input_title db "Please enter your title(Mr, Ms, Sargent, Chief, Project Leader, etc): ", 0
    introduction db "Nice to meet you ", 0
    description db "This program will generate 64-bit IEEE float numbers. ", 10, 0
    array_prompt db "How many numbers do you want. Today's limit is 100 per customer. ", 0
    storage db "Your numbers have been stored in an array. Here is that array.", 10, 0
    array_sort db "The array is now being sorted. ", 10, 0
    array_update db "Here is the updated array. ", 10, 0

	goodbye db "Good bye ", 0
    goodbye2 db ". You are welcome any time.", 10, 0

    input_invalid db "That input was invalid! Please try again. ", 10, 0
    array_normalize db "The random numbers will be normalized. Here is the normalized array ", 10, 0
    sort_normal db "The normalized numbers will be sorted. Here is the sorted normalized array ", 10, 0

    space db " ", 0
    newline db " ", 10, 0
    array_size db "%d", 0
	string_format db "%s", 10, 0

segment .bss

	array1 resq 100
	full_name resb input_length
    title resb input_length

segment .text

findName:

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

; Display input message for name
push qword 0       
mov rax, 0
mov rdi, input_name 
call printf
pop rax

push qword 0                    ; Push 0 onto the stack
mov rax, 0                      ; Move 0 to rax
mov rdi, full_name              ; Move the address of full_name to rdi
mov rsi, input_length           ; Move the value of input_length to rsi
mov rdx, [stdin]                ; Move the value of [stdin] to rdx
call fgets                      ; Call the fgets function to read input into full_name
pop rax                         ; Pop the value from the stack into rax

push qword 0
mov rax, 0
mov rdi, full_name              ; Move the address of full_name to rdi
call strlen                     ; Call the strlen function to get the length of full_name
sub rax, 1                      ; Subtract 1 from rax
mov byte [full_name + rax], 0   ; Set the byte at [full_name + rax] to 0 (terminate the string)
pop rax


; Display input message for title
push qword 0
mov rax, 0
mov rdi, input_title
call printf
pop rax
    
push qword 0
mov rax, 0
mov rdi, title                  ; Move the address of title to rdi
mov rsi, input_length           ; Move the value of input_length to rsi
mov rdx, [stdin]                ; Move the value of [stdin] to rdx
call fgets                      ; Call the fgets function to read input into title
pop rax                         

push qword 0
mov rax, 0
mov rdi, title                  ; Move the address of title to rdi
call strlen                     ; Call the strlen function to get the length of title
sub rax, 1                      ; Subtract 1 from rax
mov byte [title + rax], 0       ; Set the byte at [title + rax] to 0 (terminate the string)
pop rax


; Display program introduction
push qword 0
mov rax, 0
mov rdi, introduction
call printf
pop rax

; Display title
push qword 0
mov rax, 0
mov rdi, title
call printf
pop rax

; Display space
push qword 0
mov rax, 0
mov rdi, space
call printf
pop rax

; Display full name
push qword 0
mov rax, 0 
mov rdi, full_name
call printf
pop rax

; Display newline
push qword 0
mov rax, 0
mov rdi, newline
call printf
pop rax

; Display program description
push qword 0
mov rax, 0
mov rdi, description
call printf
pop rax

return:

; Display array prompt
push qword 0
mov rax, 0
mov rdi, array_prompt
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, array_size             ; Move the address of array_size to rdi
mov rsi, rsp                    ; Move the value of rsp (stack pointer) to rsi
call scanf                      ; Call the scanf function to read an integer from input into array_size
mov r15, [rsp]                  ; Move the value at [rsp] into r15
pop rax

cmp r15, 0                     ; Compare the value in r15 with 0
jl input_invalid               ; Jump to input_invalid if r15 is less than 0 (input is invalid)

cmp r15, 100                   ; Compare the value in r15 with 100
jg input_invalid               ; Jump to input_invalid if r15 is greater than 100 (input is invalid)

jmp continue                   ; Jump to the continue label

invalid_input:

push qword 0
mov rax, 0
mov rdi, input_invalid         ; Move the address of input_invalid to rdi
call printf                    ; Call the printf function to print the input_invalid message
pop rax                        ; Pop the value from the stack into rax

jmp return                     ; Jump to the return label

continue:

; Display array storage message
push qword 0
mov rax, 0
mov rdi, storage
call printf
pop rax

; Display newline
push qword 0
mov rax, 0
mov rdi, newline
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, array1                ; Move array1 to rdi
mov rsi, r15                   ; Move the value in r15 to rsi
call fill_random_array         ; Call the fill_random_array function
mov r14, rax                   ; Move the return value of fill_random_array to r14
pop rax

push qword 0
mov rax, 0
mov rdi, array1                ; Move the array1 to rdi
mov rsi, r14                   ; Move the value in r14 to rsi
call show_array                ; Call the show_array function
pop rax

; Display newline
push qword 0
mov rax, 0
mov rdi, newline
call printf
pop rax

push qword 0
mov rdi, array1                ; Move the array1 to rdi
mov rsi, r14                   ; Move the value in r14 to rsi
mov rdx, 8                     ; Move 8 to rdx
mov rcx, compare               ; Move the address of compare to rcx
call qsort                     ; Call the qsort function with arguments in rdi, rsi, rdx, and rcx
pop rax

; Display array sort message
push qword 0
mov rax, 0
mov rdi, array_sort
call printf 
pop rax

; Display newline
push qword 0
mov rax, 0
mov rdi, newline
call printf
pop rax

; Display array update message
push qword 0
mov rax, 0
mov rdi, array_update
call printf
pop rax

; Display newline
push qword 0
mov rax, 0 
mov rdi, newline
call printf
pop rax

push qword 0

mov rax, 0

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



