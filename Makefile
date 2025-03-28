# Toolchain
AS = nasm
CC = gcc
LD = ld
GRUB_MKRESCUE = grub-mkrescue

# Flags
ASFLAGS = -f elf32
CFLAGS = -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Iinclude -ffreestanding -c
LDFLAGS = -m elf_i386 -T linker.ld -z noexecstack

# Directories
SRCDIR = .
BUILDDIR = build
ISODIR = iso
BOOTDIR = $(ISODIR)/boot
GRUBDIR = $(BOOTDIR)/grub

# Files
KERNEL = myos.elf
ISO = myos.iso
GRUB_CFG = grub.cfg

# Objects
OBJS = $(BUILDDIR)/multiboot.o $(BUILDDIR)/boot.o $(BUILDDIR)/kernel.o $(BUILDDIR)/kernel_entry.o

all: $(ISO)

$(ISO): $(KERNEL) $(GRUB_CFG)
	mkdir -p $(GRUBDIR)
	cp $(KERNEL) $(BOOTDIR)
	cp $(GRUB_CFG) $(GRUBDIR)
	$(GRUB_MKRESCUE) -o $(ISO) $(ISODIR)

$(KERNEL): $(OBJS)
	$(LD) $(LDFLAGS) -o $(KERNEL) $(OBJS)

$(BUILDDIR)/multiboot.o: boot/multiboot.asm
	mkdir -p $(BUILDDIR)
	$(AS) -f elf32 $< -o $@

$(BUILDDIR)/boot.o: boot/boot.asm
	$(AS) $(ASFLAGS) $< -o $@

$(BUILDDIR)/kernel.o: kernel/kernel.c
	$(CC) $(CFLAGS) $< -o $@

$(BUILDDIR)/kernel_entry.o: kernel/kernel.asm
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -rf $(BUILDDIR) $(KERNEL) $(ISO) $(ISODIR)

run: $(ISO)
	qemu-system-x86_64 -cdrom $(ISO)

.PHONY: all clean run