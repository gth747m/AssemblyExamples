%define SYS_EXIT  1
%define SYS_WRITE 4
%define STDOUT    1

section .text
    global _start

_start:
    mov ebx, 3
    call proc_fact
    add eax, 0x30
    mov [fact], eax

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg
    mov edx, len
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, fact
    mov edx, 1
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, newl
    mov edx, lenl
    int 0x80

    mov eax, SYS_EXIT
    mov ebx, 0
    int 0x80

proc_fact:
    cmp ebx, 1
    jg do_calc
    mov eax, 1
    ret

do_calc:
    dec ebx
    call proc_fact
    inc ebx
    mul ebx
    ret

section .bss
    fact resb 1

section .data
    msg db "Fibonacci(3) = "
    len equ $- msg
    newl db 0xa
    lenl equ $- newl
