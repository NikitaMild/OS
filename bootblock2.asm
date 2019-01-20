[BITS 16]

org 0x7c00 ;MBR(Master Boot Record) sector

;segmentation initialization => initializing segment registers

mov ax,0x0
mov ss,ax
mov ds,ax
mov es,ax
mov fs,ax
mov gs,ax
jmp 0x0:init_cs

init_cs:
read_sectors:   ;DISK - READ SECTOR(S) INTO MEMORY
mov ah,0x2
mov al,0x6      ;number of sectors to read (must be nonzero). n=2
xor ch,ch       ;low eight bits of cylinder number.
mov cl,0x2      ;sector number 1-63 (bits 0-5). Algorithm ATA in x86 RealMode (BIOS)
xor dh,dh       ;head number (CHS model).
mov dl,0x80     ;drive number (bit 7 set for hard disk). 0x80=10000000
mov bx, 0x7e00  ;Jump Address. Model: Teensy 2.0. Chip: ATMEGA32U4
int 13h

jmp 0x7e00

self: jmp self

times (510 -($-$$)) nop

dw 0xaa55
