[bits 32]
[extern kernel_main]

section .text
global _start
_start:
    mov esp, stack_top
    call kernel_main
    cli
    hlt

section .bss
align 16
stack_bottom:
    resb 0x4000
stack_top: