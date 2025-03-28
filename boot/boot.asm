[bits 32]
[extern _start]

section .text
global loader
loader:
    ; Set up stack
    mov esp, kernel_stack + 0x4000
    
    ; Call kernel main
    call _start
    
    ; Halt if kernel returns
    cli
    hlt

section .bss
align 16
kernel_stack:
    resb 0x4000 ; 16KB stack