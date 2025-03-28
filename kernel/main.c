#include <kernel/vga.h>

void kmain(void) {
    vga_init();
    vga_puts("Hello from MyOS!\n");
    vga_puts("Linux-style OS project\n");
    
    while (1) {}
}