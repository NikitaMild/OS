/*
The first 32 interrupts:
0 - Division by zero exception
1 - Debug exception
2 - Non maskable interrupt
3 - Breakpoint exception
4 - 'Into detected overflow'
5 - Out of bounds exception
6 - Invalid opcode exception
7 - No coprocessor exception
8 - Double fault (pushes an error code)
9 - Coprocessor segment overrun
10 - Bad TSS (pushes an error code)
11 - Segment not present (pushes an error code)
12 - Stack fault (pushes an error code)
13 - General protection fault (pushes an error code)
14 - Page fault (pushes an error code)
15 - Unknown interrupt exception
16 - Coprocessor fault
17 - Alignment check exception
18 - Machine check exception
19-31 - Reserved
*/

/*
attributes IDT Desc:
P - present 1 bit - Set to 0 for unused interrupts.
DPL - Descriptor Privilege Level
S - Storage Segment - Set to 0 for interrupt and trap gates (see below).
GateType:
0b0101 - task gate 16x;
0b0110 interrupt gate 16x;
0b0111 - trap gate;
0b1110 interrupt gate 32x;
0b1111 trap gate 32x
*/

struct idt_entry{
  unsigned short offset_1;   // base_low  the offset bits 15..0 also know as pointer
  unsigned short selector;   // a code segment selector GDT
  char always_zero;          //unused, must be always zero
  char flags;                //type and attributes: 7^| P 1bit| DPL 2bits| S 1bit| GateType 3bits|^0;
  unsigned short offset_2;   // base_hight the offset bits 16..31
} __atribute__((packed));
typedef struct idt_entry IDTDescr;

struct idt_register{
  unsigned short limit; //Defines the length of the IDT in bytes - 1 (minimum value is 100h, a value of 1000h means 200h interrupts).
  unsigned int base;    //This 32 bits are the linear address where the IDT starts (INT 0)
} __atribute__((packed));
typedef struct idt_register idtr;

struct registers{
unsigned short ds;
unsigned short edi, esi, ebp, esp, ebx, edx, ecx, eax;
unsigned short int_no, err_code;
unsigned short eip, cs, eflags, useresp, ss;
}
typedef struct registers regs;

IDTDescr idt_descriptors[256];
idtr idtr_pointer;

extern void isr0 ();
extern void isr1 ();
extern void isr2 ();
extern void isr3 ();
extern void isr4 ();
extern void isr5 ();
extern void isr6 ();
extern void isr7 ();
extern void isr8 ();
extern void isr9 ();
extern void isr10 ();
extern void isr11 ();
extern void isr12 ();
extern void isr13 ();
extern void isr14 ();
extern void isr15 ();
extern void isr16 ();
extern void isr17 ();
extern void isr18 ();
extern void isr19 ();
extern void isr20 ();
extern void isr21 ();
extern void isr22 ();
extern void isr23 ();
extern void isr24 ();
extern void isr25 ();
extern void isr26 ();
extern void isr27 ();
extern void isr28 ();
extern void isr29 ();
extern void isr30 ();
extern void isr31 ();
