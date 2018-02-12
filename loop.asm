SYS_EXIT  equ 1
SYS_WRITE equ 4
STDOUT    equ 1

section .data
    msg db "Loop #"
    len equ $- msg
    newl db 0xA
    lenl equ $- newl

section .bss
    num resb 1

section .text
    global _start

_start:
    mov eax, '1'
    mov ecx, 9          ; set loop counter

l1:
    mov [num], eax      ; save eax as num
    push ecx            ; save ecx on stack

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg
    mov edx, len
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, num
    mov edx, 1
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, newl
    mov edx, lenl
    int 0x80

    mov eax, [num]
    sub eax, '0'        ; ascii to integer
    inc eax             ; increment
    add eax, '0'        ; integer to ascii
    pop ecx             ; reset ecx
    loop l1

    mov eax, SYS_EXIT
    mov ebx, 0
    int 0x80
