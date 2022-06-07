;------------------------------------------
; int slen(String message)
; String length calculation function
; arg1(rdi) str_addr
; return(rax) lenth
slen:                     
    mov     rax, rdi          ; copy the addr into rax

.nextchar:
    cmp     byte [rax], 0     ; is the byte at the rax addr 0x00?
    je      .exit             ; if so, jump out of the loop
    inc     rax               ; increment rax with by 1
    jmp     .nextchar         ; go back to compare the next character
.exit:
                              ; rax was incremented until we encountered a 
                              ; 0-byte. rdi still contains the original addr
    sub     rax, rdi          ; subtract the original addr from the new addr
                              ; the result is the amount of characters we had 
                              ; to check. It is automatically stored in rax
    ret                       ; return from the function               


;------------------------------------------
; void sprint(String message)
; String printing function
; arg1 rdi straddr
; return rax still contains the syscall return value
sprint:
    push    rsi               ; save these registers  
    push    rdi
    push    rdx
    push    rcx               ; gets clobbered by the syscall
    push    r10               ; gets clobbered by the syscall

    call    slen              ; take rdi as first arg.

    mov     rdx, rax          ; sys_write arg3 size_t len
    mov     rsi, rdi          ; sys_write arg2 char* str
    mov     rdi, 1            ; sys_write arg1 int fh = 1(stdout)
    mov     rax, 1            ; sys_write syscall number
    syscall                   ; write the string to stdout

    pop     r10               ; restore all registers
    pop     rcx
    pop     rdx
    pop     rdi
    pop     rsi
    ret


;------------------------------------------
; void exit()
; Exit program and restore resources
quit:
    mov     rdi, 0
    mov     rax, 60
    syscall
    ret

