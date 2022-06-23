void _start();

//void (*main)(void) = _start;

    asm("add ra, zero,ra");
    asm("la sp, _estack");
extern void* _estack;
extern void* _sidata, *_sdata, *_edata, *_sbss, *_ebss;
void _start() {
    void **pSrc, **pDst;
    // section data (copy from rom to ram initialized variables)
    //for(pSrc = &_sidata, pDst = &_sdata; pDst != &_edata; pSrc++, pDst++) {
    //    *pDst = *pSrc;
    //}
    // section bss (zeroing uninitialized variablses)
    //for(pDst = &_sbss; pDst != &_ebss; pDst++) {
    //    *pDst = 0;
    //}
    /* Clear the link register, so debuggers know to terminate their
     * backtrace. */
    //cfi_undefined(ra);
    /* Setup the stack pointer.  This symbol will only be looked at
     * here, so you can pick any name you want. */
    main();
    while(1);
}
