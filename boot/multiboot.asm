; Multiboot header for GRUB
section .multiboot
align 4
multiboot_header:
    dd 0x1BADB002              ; Magic number
    dd 0x00000003              ; Flags
    dd -(0x1BADB002 + 0x00000003) ; Checksum