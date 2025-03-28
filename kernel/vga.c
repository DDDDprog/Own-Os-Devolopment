#include <kernel/vga.h>

static u16* vga_buffer = (u16*)0xB8000;
static size_t vga_row = 0;
static size_t vga_col = 0;
static u8 vga_color = 0x07; // Light grey on black

void vga_init(void) {
    for (size_t y = 0; y < VGA_HEIGHT; y++) {
        for (size_t x = 0; x < VGA_WIDTH; x++) {
            const size_t index = y * VGA_WIDTH + x;
            vga_buffer[index] = (u16)' ' | (u16)vga_color << 8;
        }
    }
}

void vga_putchar(char c) {
    if (c == '\n') {
        vga_col = 0;
        if (++vga_row == VGA_HEIGHT)
            vga_row = 0;
        return;
    }
    
    const size_t index = vga_row * VGA_WIDTH + vga_col;
    vga_buffer[index] = (u16)c | (u16)vga_color << 8;
    
    if (++vga_col == VGA_WIDTH) {
        vga_col = 0;
        if (++vga_row == VGA_HEIGHT)
            vga_row = 0;
    }
}

void vga_puts(const char* str) {
    while (*str)
        vga_putchar(*str++);
}