[BITS 16]
org 0x7e00

mov ah, 0x00
mov al, 0x02
int 10h

cli
lgdt [load]
xor eax, eax
mov	eax, cr0		; set bit 0 in cr0--enter pmode
or	eax, 1
mov	cr0, eax

jmp 0x8:0x8000

%include "GDT.asm"
