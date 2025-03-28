[bits 32]
[global _start]
[extern kmain]

section .text
_start:
    ; Call C kernel main
    call kmain
    
    ; Halt if kernel returns
    cli
    hlt