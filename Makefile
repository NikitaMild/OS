CC=gcc
CFLAGS=-m32 -fno-pie -nostdlib -nodefaultlibs -nostartfiles -fno-builtin -Wno-int-to-pointer-cast -march=i386 -c
boot=bootblock
boot2=bootblock2
pmode=protectedmode
kernel=32worldandC
print=print_func
32bits=32world

first_lab: bootblock1 first_disk bochs

second_lab:	bootblock2 second_disk bochs

third_lab:	bootblock2 Pmode world third_disk bochs

four_lab:	bootblock2 Pmode 32worldC c_print linker four_disk bochs

bootblock1: $(boot).asm
	nasm -fbin $(boot).asm

bootblock2: $(boot2).asm
	nasm -fbin $(boot2).asm

world: $(32bits).asm
	nasm -fbin $(32bits).asm

Pmode:	$(pmode).asm
	nasm -fbin $(pmode).asm

32worldC: $(kernel).asm
	nasm $(kernel).asm -f elf -o $(kernel).o

c_print: $(print).c
	$(CC) $(CFLAGS) $(print).c -o $(print).o

linker: linker.ld $(kernel).o $(print).o
	ld -T linker.ld $(kernel).o $(print).o

first_disk: disk.img $(boot)
	dd if=$(boot) of=disk.img bs=512 count=1 conv=notrunc

second_disk: disk.img $(boot2) sectors
		dd if=$(boot2) of=disk.img bs=512 count=1 conv=notrunc
		dd if=sectors of=disk.img bs=512 count=3 conv=notrunc seek=1

third_disk: disk.img $(boot2) $(pmode) $(32bits)
	dd if=$(boot2) of=disk.img bs=512 count=1 conv=notrunc
	dd if=$(pmode) of=disk.img bs=512 count=1 conv=notrunc seek=1
	dd if=$(32bits) of=disk.img bs=512 count=1 conv=notrunc seek=2

four_disk: disk.img $(boot2) $(pmode)
	dd if=$(boot2) of=disk.img bs=512 count=1 conv=notrunc
	dd if=$(pmode) of=disk.img bs=512 count=1 conv=notrunc seek=1
	dd if=a.out of=disk.img bs=512 count=4 conv=notrunc seek=2

bochs: box
	./box

clean:
	rm -f $(boot)
	rm -f $(32bits)
	rm -f $(kernel).o
	rm -f $(print).o
	rm -f $(boot2)
	rm -f $(pmode)
