SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1
SYS_CALL  equ 0x80

section .data
    msg db "8 / 2 = "
    len equ $- msg
    newl db 0xA, 0xD
    lenl equ $- newl
    segment .bss
    res resb 1

section .text
    global _start

_start:
    mov ax, '8'
    sub ax, '0'
    mov bl, '2'
    sub bl, '0'
    div bl
    add ax, '0'

    mov [res], ax

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg
    mov edx, len
    int SYS_CALL

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, res
    mov edx, 1
    int SYS_CALL

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, newl
    mov edx, lenl
    int SYS_CALL

    mov eax, SYS_EXIT
    int SYS_CALL
