section .data
    name db 'Zara Ali', 0xa
    lenName equ $-name

section .text
    global _start

_start:
    mov eax,4
    mov ebx,1
    mov ecx,name
    mov edx,lenName
    int 0x80

    mov [name], dword 'Nuha'

    mov eax,4
    mov ebx,1
    mov ecx,name
    mov edx,lenName
    int 0x80

    mov eax,1
    mov ebx,0
    int 0x80
