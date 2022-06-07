; Hello World Program - asmtutor.com
; Compile with: nasm -f elf64 helloworld-len.asm
; Link with: ld -m elf_x86_64 helloworld-len.o -o helloworld-len
; Run with: ./helloworld-len

SECTION .data
msg     db      'Hello, brave new world!', 0AH, 0

SECTION .text
global  _start
    
_start: 
    mov     rdi, msg          ; move the address of our message string into rdi
    call    strlen            ; call our function to calculate the length of 
                              ; the string
    
    ; from here it is the same as before
    mov     rdx, rax          ; move the result in rdx, this prepares the third
                              ; argument for the SYS_WRITE syscall
    mov     rsi, msg          ; the addr of the string, the 2e arg SYS_WRITE
    mov     rdi, 1            ; STDOUT the first argument for SYS_WRITE 
    mov     rax, 1            ; SYS_WRITE syscall number
    syscall                   ; writes the string to STDOUT

    mov     rax, 60           ; SYS_EXIT code
    mov     rdi, 0            ; exit code 0
    syscall                   ; terminate the program


; In a way this is a bad port because it removes the need
; for pushing a value on the stack and later restoring it.
; It removes part of the original educational value. 
; TODO: restore this educational aspect
strlen:                       ; strlen function, arg1 is put in rdi
                              ; return value is put in eax
    
    mov     rax, rdi          ; copy the addr into rax

loop:
    cmp     byte [rax], 0     ; is the byte at the rax addr 0x00?
    je      exitloop          ; if so, jump out of the loop
    inc     rax               ; increment rax with by 1
    jmp     loop              ; go back to compare the next character
exitloop:
                              ; rax was incremented until we encountered a 
                              ; 0-byte. rdi still contains the original addr
    sub     rax, rdi          ; subtract the original addr from the new addr
                              ; the result is the amount of characters we had 
                              ; to check. It is automatically stored in rax
    ret                       ; return from the function