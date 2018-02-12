%define SYS_EXIT  1
%define SYS_WRITE 4
%define STDOUT    1

section .data
    msg db "The sum is: "
    len equ $- msg
    newl db 0xA
    lenl equ $- newl

section .bss
    res resb 1

section .text
    global _start

_start:
    mov ecx, 0x4
    mov edx, 0x5

    call sum
    mov [res], eax
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg
    mov edx, len
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, res
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

sum:
    mov eax, ecx
    add eax, edx
    add eax, '0'
    ret

