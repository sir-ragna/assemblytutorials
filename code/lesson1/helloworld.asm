; Hello World Program - asmtutor.com
; Compile with: nasm -f elf64 helloworld.asm
; Link with: ld -m elf_x86_64 helloworld.o -o helloworld
; Run with: ./helloworld

SECTION .data
msg     db      'Hello World!', 0Ah ; assign msg variable with your message string

SECTION .text
global  _start

_start: 

    mov     rax, 1   ; invoke SYS_WRITE (kernel opcode 1)
    mov     rdi, 1   ; file descriptor to write to. STDOUT in this case
    mov     rsi, msg ; move the memory address of our message string into ecx
    mov     rdx, 13  ; number of bytes to write - one for each letter plus 0Ah (line feed character)
    syscall
