#ifndef _KERNEL_VGA_H
#define _KERNEL_VGA_H

#include <kernel/types.h>

#define VGA_WIDTH 80
#define VGA_HEIGHT 25

void vga_init(void);
void vga_putchar(char c);
void vga_puts(const char* str);

#endif