global sum
section .text
sum:
    mov eax, ecx
    add eax, edx
    add eax, '0'
    ret

