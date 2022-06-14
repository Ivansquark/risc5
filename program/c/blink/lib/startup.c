void _start();

void (*mainPtr)(void) = _start;

extern void* _estack;
extern void* _sidata, *_sdata, *_edata, *_sbss, *_ebss;
void _start() {
    void **pSrc, **pDst;
    // section data (copy from rom to ram initialized variables)
    for(pSrc = &_sidata, pDst = &_sdata; pDst != &_edata; pSrc++, pDst++) {
        *pDst = *pSrc;
    }
    // section bss (zeroing uninitialized variablses)
    for(pDst = &_sbss; pDst != &_ebss; pDst++) {
        *pDst = 0;
    }

    main();
    while(1);
}
