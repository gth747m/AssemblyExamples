section .text
    global _start

_start:
    call display
    call newline
    mov eax, 1
    int 0x80

display:
    mov ecx, 94

next:
    push ecx
    mov eax, 4
    mov ebx, 1
    mov ecx, achar
    mov edx, 1
    int 0x80

    pop ecx
    mov dx, [achar]
    cmp byte [achar], 0xd
    inc byte [achar]
    loop next
    ret

newline:
    mov eax, 4
    mov ebx, 1
    mov ecx, newl
    mov edx, lenl
    int 0x80
    ret

section .data
    achar db 32
    newl db 0xA
    lenl equ $- newl
