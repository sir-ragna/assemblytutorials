; Hello World Program (External file include)
; Compile with: nasm -f elf64 helloworld-inc.asm
; Link with: ld -m elf_x86_64 helloworld-inc.o -o helloworld-inc
; Run with: ./helloworld-inc

%include        'functions.asm'                             ; include our external file

SECTION .data
msg1    db      'Hello, brave new world!', 0Ah, 0           ; our first message string
msg2    db      'This is how we recycle in NASM.', 0Ah, 0   ; our second message string

SECTION .text
global  _start
    
_start: 
    mov     rdi, msg1  ; move the address of our first message string into rdi
    call    sprint     ; call our string printing function
    
    mov     rdi, msg2  ; move the address of our second message string into rdi
    call    sprint     ; call our string printing function
    
    call    quit       ; call our quit function