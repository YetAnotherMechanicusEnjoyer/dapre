ENTRY(_start)

MEMORY
{
  RAM (rwx) : ORIGIN = 0x40800000, LENGTH = 512K
}

SECTIONS
{
  . = ORIGIN(RAM);

  .text :
  {
    KEEP(*(.init))
    *(.text*)
    *(.rodata*)
  } > RAM

  .data :
  {
    __data_start = .;
    *(.data*)
    __data_end = .;
  } > RAM AT > RAM

  __data_load = LOADADDR(.data);

  .bss (NOLOAD) :
  {
    __bss_start = .;
    *(.bss*)
    *(COMMON)
    __bss_end = .;
  } > RAM

  . = ALIGN(16);

  .stack (NOLOAD):
  {
    . += 8192;
    __stack_top = .;
  } > RAM

  __heap_start = .;
  __heap_end = ORIGIN(RAM) + LENGTH(RAM);

  PROVIDE(end = __heap_start);
}
