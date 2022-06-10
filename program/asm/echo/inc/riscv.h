#// -------------     STACK   ----------------------
.equ _stack_end,      0x00001000

#//-------------     LEDS    ----------------------
.equ LEDS_ODR,        0x00400000

#// -------------     UART    ----------------------
.equ UART_CTRL_REG,   0x00400100      #// 0x00000001 => start tx
.equ UART_STAT_REG,   0x00400104      #//0x00000001 => tx started
#// 0x80000000 => rx not empty    (if rx not empty we must read rdr to start another receive)
.equ UART_BAUD_REG,   0x00400108
.equ UART_TDR_REG,    0x0040010C
.equ UART_RDR_REG,    0x00400110

.macro push val #val is register
    addi    sp, sp, -4
    sw      \val, 0(sp) 
.endm
.macro pop val
    lw      \val, 0(sp)
    addi    sp, sp, 4
.endm

#Save caller registers
.macro SAVE_CONTEXT
    addi sp, sp, -64
    sw x1,  0(sp)           #save ra
    sw x5,  4(sp)           #save temp regs
    sw x6,  8(sp)
    sw x7,  12(sp)
    sw x10, 16(sp)          #save regs a0 - a7
    sw x11, 20(sp)
    sw x12, 24(sp)
    sw x13, 28(sp)
    sw x14, 32(sp)
    sw x15, 36(sp)
    sw x16, 40(sp)
    sw x17, 44(sp)
    sw x28, 48(sp)          #save temp regs
    sw x29, 52(sp)
    sw x30, 56(sp)
    sw x31, 60(sp)
.endm

#restore caller registers
.macro RESTORE_CONTEXT
    lw x1,  0(sp)
    lw x5,  4(sp)
    lw x6,  8(sp)
    lw x7,  12(sp)
    lw x10, 16(sp)
    lw x11, 20(sp)
    lw x12, 24(sp)
    lw x13, 28(sp)
    lw x14, 32(sp)
    lw x15, 36(sp)
    lw x16, 40(sp)
    lw x17, 44(sp)
    lw x28, 48(sp)
    lw x29, 52(sp)
    lw x30, 56(sp)
    lw x31, 60(sp)
    addi sp, sp, 64
.endm

