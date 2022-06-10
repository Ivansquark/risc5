.include "riscv.h"

main:
    la      sp, _stack_end
    la      s0, UART_BAUD_REG
# set BRR value (BBR+1 it is value on which divides system clk for uart_brr_clk)
    addi    s1, x0, 0x0         
    sw      s1, 0(s0)
# set byte to uart TDR
    la      s0, UART_TDR_REG
    addi    s1, x0, 'S'
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
    addi    s1, x0, 'T'
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
#while(1) check rx not empty flag
while_not_rx:
    la      a0, UART_STAT_REG
    lw      a1, 0(a0)
    lui     t0, 0x80000
    and     a1, a1, t0              # check rx not empty last bit
    beq     x0, a1, while_not_rx    # while loop
#turn off led
    la      s2, LEDS_ODR
    li      s3, 0x00000000
    sw      s3, 0(s2)

# get byte
    la      a2, UART_RDR_REG
    lw      a1, 0(a2)
    addi    t0, x0, 'R'
    push    t0
    pop     t0
    bne    t0, a1, echo_byte   
    j     main

echo_byte:
 # set byte to uart TDR
    la      s0, UART_TDR_REG
    add     s1, x0, a1       #copy received byte
    sw      s1, 0(s0)
#turn on led
    la      s2, LEDS_ODR
    li      s3, 0x10000001
    sw      s3, 0(s2)
#start tx
    la      s0, UART_CTRL_REG
    addi    s1, x0, 1
    sw      s1, 0(s0)
check_tx_complete_echo:
    la      a0, UART_STAT_REG
    lw      a1, 0(a0)
    andi    a1, a1, 1
    bne     x0, a1, while_not_rx #wait for new byte
      

