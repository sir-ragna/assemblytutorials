; Hello World Program - asmtutor.com
; Compile with: nasm -f elf64 helloworld-len.asm
; Link with: ld -m elf_x86_64 helloworld-len.o -o helloworld-len
; Run with: ./helloworld-len

SECTION .data
msg     db      'Hello, brave new world!', 0Ah, 0 ; we can modify this now without having to update anywhere else in the program

SECTION .text
global  _start
    
_start: 
    mov     rdi, msg          ; store the original addr in rdi
    mov     rax, msg          ; store the msg addr in rax

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
    mov     rdx, rax          ; move the result in rdx, this prepares the third
                              ; argument for the SYS_WRITE syscall
    mov     rsi, msg          ; the addr of the string, the 2e arg SYS_WRITE
    mov     rdi, 1            ; STDOUT the first argument for SYS_WRITE 
    mov     rax, 1            ; SYS_WRITE syscall number
    syscall                   ; writes the string to STDOUT

    mov     rax, 60           ; SYS_EXIT code
    mov     rdi, 0            ; exit code 0
    syscall                   ; terminate the program

    ; This does not get executed anymore.
    ; An alternative more advanced way of calculating the str length using
    ; the repne and scasb instructions.
    ; --------------------------------------------
    xor     al,al    ; zero out the first byte of rax

    mov     rcx, 0   ;
    dec     rcx      ; put rcx on the maximum available number

    mov     rdi, msg ; put the msg addr in rbi
repne scasb          ; repeat while(al != [rbi++])
                     ; repne stands for repeat while negative. It only works with
                     ; a select few instructions
                     ; scasb checks whether rbi points to a byte that matches 
                     ; the first byte of the rax register(al).

    not     rcx      ; negate rcx
    dec     rcx      ; decrement 1 to remove the 0-byte
    ; end of length of string calculation

    mov     rdi, 1            ; arg1 (output) for SYS_WRITE
    mov     rsi, msg          ; arg2 (addr) for SYS_WRITE
    mov     rdx, rcx          ; arg3 (len) for SYS_WRITE
    mov     rax, 1            ; syscall code 1
    syscall

    mov     rax, 60  ; SYS_EXIT code
    mov     rdi, rcx ; put the amount of characters as the exit code
    syscall
