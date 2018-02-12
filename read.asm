section .data
    usrMsg db 'Please enter a number: '
    lenUsrMsg equ $-usrMsg
    dispMsg db 'You entered: '
    lenDispMsg equ $-dispMsg

section .bss
    num resb 5

section .text
    global _start

_start:
    ; Prompt
    mov eax,4   ; sys_write
    mov ebx,1
    mov ecx,usrMsg
    mov edx,lenUsrMsg
    int 0x80
    ; Read User Input
    mov eax,3   ; sys_read
    mov ebx,1
    mov ecx,num
    mov edx,5   ; 5 byes (numeric 1 for sign)
    int 0x80
    ; Output Message
    mov eax,4
    mov ebx,1
    mov ecx,dispMsg
    mov edx,lenDispMsg
    int 0x80
    ; Output the number
    mov eax,4
    mov ebx,1
    mov ecx,num
    mov edx,5
    int 0x80
    ; Exit
    mov eax,1
    mov ebx,0
    int 0x80
