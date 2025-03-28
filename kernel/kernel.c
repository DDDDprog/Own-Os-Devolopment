#include "kernel.h"

static size_t terminal_row;
static size_t terminal_column;
static uint8_t terminal_color;
static uint16_t* terminal_buffer;

void terminal_initialize(void) {
    terminal_row = 0;
    terminal_column = 0;
    terminal_color = 0x07; // Light grey on black
    terminal_buffer = (uint16_t*) 0xB8000;
    
    for (size_t y = 0; y < VGA_HEIGHT; y++) {
        for (size_t x = 0; x < VGA_WIDTH; x++) {
            const size_t index = y * VGA_WIDTH + x;
            terminal_buffer[index] = (uint16_t) ' ' | (uint16_t) terminal_color << 8;
        }
    }
}

void terminal_putchar(char c) {
    if (c == '\n') {
        terminal_column = 0;
        if (++terminal_row == VGA_HEIGHT) {
            terminal_row = 0;
        }
        return;
    }
    
    const size_t index = terminal_row * VGA_WIDTH + terminal_column;
    terminal_buffer[index] = (uint16_t) c | (uint16_t) terminal_color << 8;
    
    if (++terminal_column == VGA_WIDTH) {
        terminal_column = 0;
        if (++terminal_row == VGA_HEIGHT) {
            terminal_row = 0;
        }
    }
}

void terminal_writestring(const char* data) {
    while (*data != '\0') {
        terminal_putchar(*data++);
    }
}

void kmain(void) {
    terminal_initialize();
    terminal_writestring("Hello, World!\n");
    terminal_writestring("MyOS is running!\n");
    
    while (1) {
        // Kernel loop
    }
}