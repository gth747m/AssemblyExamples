SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

segment .data
    msg1 db "Enter a single digit: "
    len1 equ $- msg1
    msg2 db " + "
    len2 equ $- msg2
    msg3 db " = "
    len3 equ $- msg3
    newl db 0xA, 0xD
    lenl equ $- newl

segment .bss
    num1 resb 2
    num2 resb 2
    res  resb 1

section .text
    global _start

_start:
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg1
    mov edx, len1
    int 0x80

    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, num1
    mov edx, 2
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg1
    mov edx, len1
    int 0x80

    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, num2
    mov edx, 2
    int 0x80

    ; Move first num to eax and second to ebx
    ; subtract ascii 0 to convert ascii to decimal
    mov eax, [num1]
    sub eax, '0'
    mov ebx, [num2]
    sub ebx, '0'

    ; Add the two numbers and convert back to ascii
    add eax, ebx
    add eax, '0'

    ; Store the sum in memory
    mov [res], eax

    ; Print result
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, num1
    mov edx, 1
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg2
    mov edx, len2
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, num2
    mov edx, 1
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg3
    mov edx, len3
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, res
    mov edx, 1
    int 0x80

    ; Print new line
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, newl
    mov edx, lenl
    int 0x80

exit:
    mov eax, SYS_EXIT
    xor ebx, ebx
    int 0x80
