%define SYS_EXIT  1
%define SYS_WRITE 4
%define STDOUT    1

section .data
    msg db "Sum of 2 + 3 + 4 = "
    len equ $-msg
    newl db 0xA
    lenl equ $-newl
    global x
x:
    db 2
    db 3
    db 4
sum:
    db 0

section .text
    global _start

_start:
    mov eax, 3
    mov ebx, 0
    mov ecx, x

top:
    add ebx, [ecx]
    add ecx, 1
    dec eax
    jnz top

    add ebx, '0'
    mov [sum], ebx

    ; Print Message
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg
    mov edx, len
    int 0x80
    
    ; Print Sum
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, sum
    mov edx, 1
    int 0x80

    ; New Line
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, newl
    mov edx, lenl
    int 0x80

    ; SYS_EXIT(0)
    mov eax, SYS_EXIT
    mov ebx, 0
    int 0x80
