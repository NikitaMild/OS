OUTPUT_FORMAT(binary)
OUTPUT_ARCH(i386)

SECTIONS
{
  . = 0x8000;
.text . : { 32worldandC.o(.text) }
.data : { *(.rodata)}
.bss  : { *(.bss)  }

}



/*
.text program code;
.rodata read-only data;
.data read-write initialized data;
.bss read-write zero initialized data.
EXCLUDE FILE may be used to match all files except
the ones specified in the EXCLUDE FILE list
*/
