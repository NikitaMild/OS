[BITS 32]
org 0x8000

mov		ax, 0x10		; set data segments to data selector (0x10)
mov		ds, ax
mov		ss, ax
mov		es, ax

self: jmp self
