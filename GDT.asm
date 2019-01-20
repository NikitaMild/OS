;**************************************************************************
;**********************  GDT TABLE INITIALIZIATION ************************
;**************************************************************************
  ;Bits 56-63: Bits 24-32 of the base address
  ;Bit 55: Granularity
    ;0: None
    ;1: Limit gets multiplied by 4K
  ;Bit 54: Segment type
    ;0: 16 bit
    ;1: 32 bit
  ;Bit 53: Reserved-Should be zero
  ;Bits 52: Reserved for OS use
  ;Bits 48-51: Bits 16-19 of the segment limit
  ;Bit 47 Segment is in memory (Used with Virtual Memory) if P=0 #NP (not present)
  ;Bits 45-46: Descriptor Privilege Level
    ;0: (Ring 0) Highest
    ;3: (Ring 3) Lowest
  ;Bit 44: Descriptor Bit
    ;0: System Descriptor
    ;1: Code or Data Descriptor
  ;Bits 41-43: Descriptor Type
  ;Bit 43: Executable segment
    ;0: Data Segment
    ;1: Code Segment
  ;Bit 42: Expansion direction (Data segments), conforming (Code Segments)
  ;Bit 41: Readable and Writable
    ;0: Read only (Data Segments); Execute only (Code Segments)
    ;1: Read and write (Data Segments); Read and Execute (Code Segments)
  ;Bit 40: Access bit (Used with Virtual Memory)
  ;Bits 16-39: Bits 0-23 of the Base Address
  ;Bits 0-15: Bits 0-15 of the Segment Limit
;**************************************************************************
start:
null_descriptor:
dq 0x0
; Offset 0x8
code_descriptor:
dw 0xFFFF
dw 0x0
db 0x0
db 0b10011010
db 0b11001111
db 0x0
; Offset 0x10
data_descriptor:
dw 0xFFFF
dw 0x0
db 0x0
db 0b10010010
db 0b11001111
db 0x0
; Offset 0x18 etc.
end_of_gdt:
load:
dw end_of_gdt - start - 1  ;size of the GDT - 1
dd null_descriptor ;actual address of the GDT
