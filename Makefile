CC=gcc
CFLAGS=-m32 -fno-pie -nostdlib -nodefaultlibs -nostartfiles -fno-builtin -Wno-int-to-pointer-cast -march=i386 -c

first_lab: bootblock1 first_disk bochs

second_lab:	bootblock2 second_disk bochs

third_lab:	bootblock2 Pmode world third_disk bochs

four_lab:	bootblock2 Pmode 32worldC c_print linker four_disk bochs

bootblock1: bootblock.asm
	nasm -fbin bootblock.asm

bootblock2: bootblock2.asm
	nasm -fbin bootblock2.asm

world: 32world.asm
	nasm -fbin 32world.asm

Pmode:	protectedmode.asm
	nasm -fbin protectedmode.asm

32worldC: 32worldandC.asm
	nasm 32worldandC.asm -f elf -o 32worldandC.o

c_print: print_func.c
	$(CC) $(CFLAGS) print_func.c -o print_func.o

linker: linker.ld 32worldandC.o print_func.o
	ld -T linker.ld 32worldandC.o print_func.o

first_disk: disk.img bootblock
	dd if=bootblock of=disk.img bs=512 count=1 conv=notrunc

second_disk: disk.img bootblock2 sectors
		dd if=bootblock2 of=disk.img bs=512 count=1 conv=notrunc
		dd if=sectors of=disk.img bs=512 count=3 conv=notrunc seek=1

third_disk: disk.img bootblock2 protectedmode 32world
	dd if=bootblock2 of=disk.img bs=512 count=1 conv=notrunc
	dd if=protectedmode of=disk.img bs=512 count=1 conv=notrunc seek=1
	dd if=32world of=disk.img bs=512 count=1 conv=notrunc seek=2

four_disk: disk.img bootblock2 protectedmode 32world
	dd if=bootblock2 of=disk.img bs=512 count=1 conv=notrunc
	dd if=protectedmode of=disk.img bs=512 count=1 conv=notrunc seek=1
	dd if=a.out of=disk.img bs=512 count=4 conv=notrunc seek=2

bochs: box
	./box
