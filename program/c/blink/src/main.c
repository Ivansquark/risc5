#include "rv_defs.h"
#include "stdint.h"
void delay(uint8_t clocks);

void main(void) {
    volatile uint8_t received_byte = 5;
    //set UART prscaler
    *(uint32_t *)UART_BAUD_REG = 0x00000002;
    while(1) {
        if((*(uint32_t *)UART_STAT_REG & UART_RX_READY) == 1) {
            received_byte = *(uint32_t *)UART_RDR_REG;
        }
        delay(received_byte);
        *(uint32_t *)LEDS_ODR |= 0x000000FF;
        delay(received_byte);
        *(uint32_t *)LEDS_ODR &= ~0x000000FF;
        //send uart
        *(uint32_t *)UART_TDR_REG = received_byte;
        *(uint32_t *)UART_CTRL_REG = 0x00000001;
        while((*(uint32_t*)UART_STAT_REG) & (0x00000001)) {}
    }
    return;
}

void delay(uint8_t clocks) {
    for(volatile uint8_t i = 0; i < clocks; i++) {}
}
