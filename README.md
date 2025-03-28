MyOS - A Minimal Operating System
OS Demo
License

A minimal operating system kernel written in Assembly and C, bootable with GRUB.

Features
32-bit protected mode

Basic VGA text mode output

Multiboot compliant (works with GRUB)

Simple Makefile-based build system

QEMU emulator support

Requirements
NASM (Netwide Assembler)

GCC (GNU Compiler Collection)

GNU Make

GNU GRUB (for creating bootable ISO)

QEMU (for testing)

Installation
Dependencies (Ubuntu/Debian)
bash
Copy
sudo apt-get install build-essential nasm grub-pc-bin qemu-system-x86 gcc-multilib
Building
Clone the repository:

bash
Copy
git clone https://github.com/yourusername/myos.git
cd myos
Build the OS:

bash
Copy
make
Run in QEMU:

bash
Copy
make run
Project Structure
Copy
myos/
├── boot/               # Bootloader components
│   ├── boot.asm        # Bootstrap code
│   └── multiboot.asm   # Multiboot header
├── kernel/             # Kernel source
│   ├── kernel.c        # Main kernel code
│   └── kernel.asm      # Kernel entry point
├── include/            # Header files
│   └── kernel.h        # Kernel header
├── iso/                # ISO directory structure
│   └── boot/
│       └── grub/
├── linker.ld           # Linker script
├── Makefile            # Build configuration
├── grub.cfg            # GRUB configuration
└── README.md           # This file
Customization
To modify the displayed message, edit kernel/kernel.c:

c
Copy
void kmain(void) {
    terminal_initialize();
    terminal_writestring("Your custom message here!\n");
    // ...
}
Running on Real Hardware
Create a bootable USB:

bash
Copy
dd if=myos.iso of=/dev/sdX bs=4M status=progress
(Replace /dev/sdX with your actual USB device)

Boot from the USB device

Troubleshooting
Error: Missing grub.cfg

Ensure grub.cfg exists in the project root

Error: Missing standard headers

The project is designed to work without standard libraries

All necessary types are defined in include/kernel.h

QEMU not starting

Verify QEMU is installed correctly

Try running with: qemu-system-x86_64 -cdrom myos.iso -serial stdio

License
MIT License - See LICENSE for details.

Contributing
Contributions are welcome! Please open an issue or pull request.

Acknowledgments
OSDev.org community

James Molloy's Kernel Development Tutorials

GNU GRUB documentation

To create this README file in your project:

bash
Copy
cat > README.md << 'EOF'
[PASTE THE ENTIRE README CONTENT ABOVE HERE]
EOF
This README provides:

Clear installation and usage instructions

Project structure overview

Customization guidance

Troubleshooting tips

Licensing information

Clean formatting with badges

You can further customize it by:

Adding screenshots of your OS running

Including more detailed development documentation

Adding a roadmap or feature list

Expanding the troubleshooting section
