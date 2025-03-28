[bits 32]
[global kernel_main]
[extern kmain]

kernel_main:
    call kmain
    cli
    hlt