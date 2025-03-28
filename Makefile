ARCH := x86
CROSS_COMPILE :=
CC := $(CROSS_COMPILE)gcc
AS := nasm
LD := $(CROSS_COMPILE)ld

CFLAGS := -m32 -std=gnu99 -ffreestanding -Wall -Wextra -Iinclude
ASFLAGS := -f elf32
LDFLAGS := -m elf_i386 -nostdlib -T linker.ld -z noexecstack

KERNEL := myos.elf
ISO := myos.iso

SRCDIR := .
OBJDIR := build
ISODIR := iso
BOOTDIR := $(ISODIR)/boot
GRUBDIR := $(BOOTDIR)/grub

ARCHDIR := arch/$(ARCH)
KERNELDIR := kernel

SOURCES := \
    $(ARCHDIR)/boot/multiboot.asm \
    $(ARCHDIR)/boot/boot.asm \
    $(ARCHDIR)/kernel/entry.asm \
    $(KERNELDIR)/main.c \
    $(KERNELDIR)/vga.c

OBJECTS := $(patsubst %,$(OBJDIR)/%.o,$(basename $(SOURCES)))

.PHONY: all clean run iso

all: $(KERNEL)

iso: $(ISO)

$(ISO): $(KERNEL) scripts/grub.cfg
	mkdir -p $(GRUBDIR)
	cp $(KERNEL) $(BOOTDIR)
	cp scripts/grub.cfg $(GRUBDIR)
	grub-mkrescue -o $(ISO) $(ISODIR)

$(KERNEL): $(OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $^

$(OBJDIR)/%.o: %.asm
	mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) -o $@ $<

$(OBJDIR)/%.o: %.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -rf $(OBJDIR) $(KERNEL) $(ISO) $(ISODIR)

run: $(ISO)
	qemu-system-x86_64 -cdrom $(ISO)