# FluffyOS
FluffyOS is a very basic operating system written in 8086 assembly.
In fact, at this early stage of development it is more of a boot sector program than an OS.

## Development Environment
There are a number of solutions to build, compile and run FluffyOS.
I would recommend the NASM assembler and Bochs emulator.

## Commands to Compile and Run
nasm bootloader.asm -f bin -o ../bin/bootloader.bin
bochs -q -f bochs_config.bxrc
