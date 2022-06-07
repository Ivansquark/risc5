.equ _stack_end,    0x00001000
.equ UART_CTRL_REG, 0x00400100
# 0x00000001 => start tx
.equ UART_STAT_REG, 0x00400104
# 0x00000001 => tx started
.equ UART_BAUD_REG, 0x00400108
.equ UART_TDR_REG,  0x0040010C
.equ UART_RDR_REG,  0x00400110

main:
    la      sp, _stack_end
    la      s0, UART_BAUD_REG
    addi    s1, x0, 0x0
    sw      s1, 0(s0)
# set byte to uart TDR
    la      s0, UART_TDR_REG
    addi    s1, x0, 'O'
    sw      s1, 0(s0)
#start tx
    la      s0, UART_CTRL_REG
    addi    s1, x0, 1
    sw      s1, 0(s0)    
check_tx_complete0:
    la      a0, UART_STAT_REG
    lw      a1, 0(a0)
    andi    a1, a1, 1
    bne     x0, a1, check_tx_complete0
#tx_complete

# set byte to uart TDR
    la      s0, UART_TDR_REG
    addi    s1, x0, 'P'
    sw      s1, 0(s0)
#start tx
    la      s0, UART_CTRL_REG
    addi    s1, x0, 1
    sw      s1, 0(s0)    
check_tx_complete1:
    la      a0, UART_STAT_REG
    lw      a1, 0(a0)
    andi    a1, a1, 1
    bne     x0, a1, check_tx_complete1
#tx_complete
       

