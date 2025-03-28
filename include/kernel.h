#ifndef KERNEL_H
#define KERNEL_H

// Define basic types manually
typedef unsigned int size_t;
typedef unsigned char uint8_t;
typedef unsigned short uint16_t;

#define VGA_WIDTH 80
#define VGA_HEIGHT 25

void terminal_initialize(void);
void terminal_putchar(char c);
void terminal_writestring(const char* data);

#endif