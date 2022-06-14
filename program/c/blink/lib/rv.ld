OUTPUT_ARCH( "riscv" )

ENTRY( _start )
/*_StackTop = 0x00000200 */
_Min_Stack_Size = 0x0100;  /*256K*/

MEMORY
{ 
	/* Run in FLASH */ 
	rom     (rxai!w) : ORIGIN = 0x00000000, LENGTH = 1k
	ram     (wxa!ri) : ORIGIN = 0x00000000, LENGTH = 1K 
}

SECTIONS
{  
    __stack_size = DEFINED(_Min_Stack_Size) ? _Min_Stack_Size : 256;
    . = ALIGN(4);
/*  .vectors :
    {
        KEEP (*(SORT_NONE(.vectors)))
    } >flash  
*/
    .text           :
    {   
        *(.text .text.*)
    } >rom 
 
    . = ALIGN(4);
  
   /* PROVIDE( _eilm = . ); /*instruction local memory*/
    .rodata :
    {
        . = ALIGN(4);
        *(.rodata)         /* .rodata sections (constants, strings, etc.) */
        *(.rodata*)    
    } >rom
    PROVIDE (_etext = .);

    . = ALIGN(16);
    _sidata = .;    /* start data section in rom */

	.stack :              
    {
        . = ALIGN(16);
    	_stack_begin = .;
    	_StackLimit = _stack_begin + __stack_size; 
    	. = . + __stack_size;
        _StackTop = .;  /* stack ptr is in start of ram + stack_size */
        . = ALIGN(16);  
        PROVIDE(_estack = _StackTop);
    }>ram

    /* initialized variables after stack */
    . = ALIGN(4);
    .data : {
        PROVIDE(_sdata = .);
        *(.rdata)    
        . = ALIGN(4);
        *(.sdata .sdata.*) /* start data section in ram */
    } >ram AT>rom   /* alias from rom to ram */

    . = ALIGN(4);
    PROVIDE( _edata = . );

    PROVIDE( _sbss = . );
    .bss            :
    {
        *(.sbss*)
        *(.bss .bss.*)
        *(COMMON)
        . = ALIGN(4);
    } >ram

    . = ALIGN(4);
    PROVIDE( _ebss = . );  
    PROVIDE( end = . );
}
