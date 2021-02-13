cd src

nasm bootloader.asm -f bin -o ../bin/bootloader.bin
nasm kernel.asm -f bin -o ../bin/kernel.bin
cat ../bin/bootloader.bin ../bin/kernel.bin > ../bin/FluffyOS