SYS_WRITE equ 4
STDOUT    equ 1

section .data
    msg db "The largest digit is: "
    len equ $- msg
    newl db 0xA
    lenl equ $- newl
    num1 dd '22'
    num2 dd '47'
    num3 dd '31'

section .bss
    largest resb 2

section _text
    global _start

_start:
    mov ecx, [num1]
    cmp ecx, [num2]
    jg check_third
    mov ecx, [num2]

check_third:
    cmp ecx, [num3]
    jg _exit
    mov ecx, [num3]

_exit:
    mov [largest], ecx
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg
    mov edx, len
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, largest
    mov edx, 2
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, newl
    mov edx, lenl
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80
