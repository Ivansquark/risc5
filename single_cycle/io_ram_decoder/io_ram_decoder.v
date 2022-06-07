`include "../rv_defs.v"
module io_ram_decoder(
    input [31:0]address,
    input we,
    output reg [31:0] address_to_ram,
    output reg we_ram,
    output reg we_uart,
    output reg we_led,
    output reg [2:0] uart_reg_mux_out,
    output reg load_mux     // 0-ram 1-uart regs
);

wire isIO = address[22];
wire isRam = !isIO;

always @* begin
    address_to_ram = address;
    if(isRam) begin
        if(we)  we_ram = 1;
        else    we_ram = 0;
        we_uart = 0;
        we_led = 0;
        load_mux = 0;
        load_mux = `LOAD_MUX_RAM;
    end
    else begin
        if(address == `LED_REG_ADDR) we_led = 1;
        else if(address == `UART_CTRL_REG) begin
            if(we) begin 
                we_uart = 1; we_ram = 0; we_led = 0;
                uart_reg_mux_out = `UART_MUX_CTRL;
            end
            else begin
                we_uart = 0; we_ram = 0; we_led = 0;
                load_mux = `LOAD_MUX_UART;
            end
        end
        else if(address == `UART_STAT_REG) begin
            if(we) begin 
                we_uart = 1; we_ram = 0; we_led = 0;
                uart_reg_mux_out = `UART_MUX_STAT;
            end
            else begin
                we_uart = 0; we_ram = 0; we_led = 0;
                load_mux = `LOAD_MUX_UART;
            end
        end
        else if(address == `UART_BAUD_REG) begin
            if(we) begin 
                we_uart = 1; we_ram = 0; we_led = 0;
                uart_reg_mux_out = `UART_MUX_BAUD;
            end
            else begin
                we_uart = 0; we_ram = 0; we_led = 0;
                load_mux = `LOAD_MUX_UART;
            end
        end
        else if(address == `UART_TDR_REG) begin
            if(we) begin 
                we_uart = 1; we_ram = 0; we_led = 0;
                uart_reg_mux_out = `UART_MUX_TDR;
            end
            else begin
                we_uart = 0; we_ram = 0; we_led = 0;
                load_mux = `LOAD_MUX_UART;
            end
        end
        else if(address == `UART_RDR_REG) begin
            if(we) begin 
                we_uart = 1; we_ram = 0; we_led = 0;
                uart_reg_mux_out = `UART_MUX_RDR;
            end
            else begin
                we_uart = 0; we_ram = 0; we_led = 0;
                load_mux = `LOAD_MUX_UART;
            end
        end
    end
end

endmodule
