SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1
SYS_CALL  equ 0x80


section .data
    msg db "3 * 2 = "
    len equ $- msg
    newl db 0xA, 0xD
    lenl equ $- newl
    segment .bss
    res resb 1

section .text
    global _start

_start:
    mov al, '3'
    sub al, '0'
    mov bl, '2'
    sub bl, '0'
    mul bl
    add al, '0'

    mov [res], al

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
