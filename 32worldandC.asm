[BITS 32]
extern main

mov		ax, 0x10		; set data segments to data selector (0x10)
mov		ds, ax
mov		ss, ax
mov		es, ax

call main

self: jmp self
