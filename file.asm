%define SYS_EXIT  1
%define SYS_FORK  2
%define SYS_READ  3
%define SYS_WRITE 4
%define SYS_OPEN  5
%define SYS_CLOSE 6
%define SYS_CREAT 8
%define SYS_LSEEK 19
%define STDOUT    1


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
    ; Open file
    mov eax, SYS_CREAT
    mov ebx, filename
    mov ecx, 0777
    int 0x80
    mov [fout], eax
    ; Write to file
    mov eax, SYS_WRITE
    mov ebx, [fout]
    mov ecx, msg
    mov edx, len
    int 0x80
    ; Close file
    mov eax, 6
    mov ebx, [fout]
    ; Tell user
    write_string msg_done, len_done
    write_string msg, len
    
    ; Open file
    mov eax, SYS_OPEN
    mov ebx, filename
    mov ecx, 0          ; read-only
    mov edx, 0777
    int 0x80
    mov [fin], eax
    ; Read from file
    mov eax, SYS_READ
    mov ebx, [fin]
    mov ecx, info
    mov edx, 26
    int 0x80
    ; Tell user
    write_string msg_read, len_read
    write_string info, 26

exit:
    mov eax, 1
    int 0x80

section .data
    filename db "myfile.txt",0
    msg db "Hello World!", 0xa
    len equ $-msg
    msg_done db "Wrote to file: "
    len_done equ $-msg_done
    msg_read db "Read from file: "
    len_read equ $-msg_read

section .bss
    fout resb 1
    fin  resb 1
    info resb 26
