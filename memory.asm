%define SYS_BRK 45

%macro write_string 2 
    mov   eax, 4
    mov   ebx, 1
    mov   ecx, %1
    mov   edx, %2
    int   80h
%endmacro


section .text
    global _start

_start:
    mov eax, SYS_BRK
    xor ebx, ebx
    int 0x80

    add eax, 16384  ; nuber of bytes to reserve
    mov ebx, eax
    mov eax, SYS_BRK
    int 0x80

    cmp eax, 0
    jl exit
    mov edi, eax    ; EDI = highest available address
    sub edi, 4      ; point to last DWORD
    mov ecx, 4096   ; number of DWORDS allocated
    xor eax, eax    ; clear eax
    std             ; backward
    rep stosd       ; repeat for entire allocated area
    cld             ; put df flag in normal state

    write_string msg, len

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80

section .data
    msg db "Allocated 16 kb of memory!", 0xa
    len equ $-msg
