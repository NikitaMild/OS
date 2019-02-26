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
;----------------------------------------------------
;------Output on the display 80*25 spaces------------
;----------------------------------------------------
;mov ax, 0xb800  ;beginning of the segment VRAM
;mov es, ax      ; mov to extra segment
;or bx,bx
;space:
;mov [es:bx], byte 0x20
;add bx,2
;cmp bx,0xfa0
;jne space
;-----------------------------------------------------

;clear_window:
;mov ah,0x0
;mov al,0x2
;int 10h

clear_window:
mov ah,0x2    ;set cursor
xor bh,bh
xor dx,dx     ;(0,0)
int 10h
mov ah,0x9     ;clear display
mov cx,80*25*2   ;hex(80*25*2)
mov al,0x20
mov bl,0x7
int 10h

;mov ax, 0xb800  ;beginning of the segment VRAM
;mov es, ax      ; mov to extra segment
;xor bx,bx
;lea di,[es:bx]
;lea si, [msg]     ;address msg to address SI(Source Index)
;mov cx, len
;rp:
;movsb
;inc di
;loop rp

set_cursor:
mov ah,0x2
xor bh,bh
xor dx,dx
int 10h

write_string:
mov ah,0x13
mov al,0x1      ;Update cursor after writing
xor bh,bh
mov bl,0xf      ;??? attribute if string contains only characters.
mov cx,len      ;number of characters in string
mov dh,0xb      ;row
mov dl,0x20     ;column
mov bp, msg     ;string to write
int 10h

self: jmp self

msg db 'Hello, World!'
len equ $ - msg

times (510 -($-$$)) nop

dw 0xaa55
