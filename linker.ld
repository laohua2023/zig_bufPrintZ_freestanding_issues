
#include <Platform_def.h>

/*
OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
OUTPUT_ARCH(aarch64)
*/

OUTPUT_ARCH( "riscv" )
OUTPUT_FORMAT("elf64-littleriscv")
ENTRY(_start)

SECTIONS {
	. = 0x80000000;
	. = ALIGN(8);
    __text_start = .;
    .text : 
	{ 
		KEEP(*(.text.boot))
		STARTOBJ(.text)
		*(.text) 
	}

    .rodata ALIGN(8) : {*(.rodata*)} 
    .data   ALIGN(8) : { *(.data) }

    . = ALIGN(8);
    __bss_start = .;
     .bss   ALIGN(8)  : { *(.bss)  *(COMMON) }
    __bss_end = .;

    .got   ALIGN(8) : { *(.got) }

	. = . + 64k; /*  64kB of stack memory => 1MB */
	stack_top = .;

	/DISCARD/ : { *(.dynsym) }
	/DISCARD/ : { *(.dynstr*) }
	/DISCARD/ : { *(.dynamic*) }
	/DISCARD/ : { *(.plt*) }
	/DISCARD/ : { *(.interp*) }
	/DISCARD/ : { *(.gnu*) }
	/DISCARD/ : { *(.comment*) }
}

