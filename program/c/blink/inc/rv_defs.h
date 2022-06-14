// -------------     STACK   ----------------------
#define _stack_end      0x00000400

//-------------     LEDS    ----------------------
#define LEDS_ODR        0x00400000

// -------------     UART    ----------------------
#define UART_CTRL_REG   0x00400100      // 0x00000001 => start tx
#define UART_STAT_REG   0x00400104      //0x00000001 => tx started
// 0x80000000 => rx not empty    (if rx not empty we must read rdr to start another receive)
#define UART_BAUD_REG   0x00400108
#define UART_TDR_REG    0x0040010C
#define UART_RDR_REG    0x00400110

#define UART_RX_READY   0x80000000
