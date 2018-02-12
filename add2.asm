%define SYS_EXIT  1
%define SYS_WRITE 4
%define STDOUT    1

section .data
    msg db 'Sum = '
    len equ $- msg
    newl db 0xA
    lenl equ $- newl
    num1 db '12345'
    num2 db '23456'
    sum  db '     '

section .text
    global _start

_start:
    mov esi, 4 ; pointer to rightmost digit
    mov ecx, 5 ; number of digits
    clc

add_loop:
    mov al, [num1 + esi]
    adc al, [num2 + esi]
    aaa
    pushf
    or  al, 0x30
    popf
    mov [sum+esi], al
    dec esi
    loop add_loop

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg
    mov edx, len
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, sum
    mov edx, 5
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, newl
    mov edx, lenl
    int 0x80

    mov eax, SYS_EXIT
    mov ebx, 0
    int 0x80
