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
        if(we)  begin 
            we_ram = 1; we_uart = 0; we_led = 0;
        end
        else begin 
            we_ram = 0; we_uart = 0; we_led = 0;
        end
        load_mux = `LOAD_MUX_RAM;
        uart_reg_mux_out = `UART_MUX_CTRL;
    end
    else begin
        load_mux = `LOAD_MUX_UART;
        if(address == `LED_REG_ADDR) begin 
            we_led = 1; we_uart = 0; we_ram = 0;
        end
        else if(address == `UART_CTRL_REG) begin
            uart_reg_mux_out = `UART_MUX_CTRL;
            if(we) begin 
                we_uart = 1; we_ram = 0; we_led = 0;
            end
            else begin
                we_uart = 0; we_ram = 0; we_led = 0;
            end
        end
        else if(address == `UART_STAT_REG) begin
            uart_reg_mux_out = `UART_MUX_STAT;
            if(we) begin 
                we_uart = 1; we_ram = 0; we_led = 0;
            end
            else begin
                we_uart = 0; we_ram = 0; we_led = 0;
            end
        end
        else if(address == `UART_BAUD_REG) begin
            uart_reg_mux_out = `UART_MUX_BAUD;
            if(we) begin 
                we_uart = 1; we_ram = 0; we_led = 0;
            end
            else begin
                we_uart = 0; we_ram = 0; we_led = 0;
            end
        end
        else if(address == `UART_TDR_REG) begin
            uart_reg_mux_out = `UART_MUX_TDR;
            if(we) begin 
                we_uart = 1; we_ram = 0; we_led = 0;
            end
            else begin
                we_uart = 0; we_ram = 0; we_led = 0;
            end
        end
        else if(address == `UART_RDR_REG) begin
            uart_reg_mux_out = `UART_MUX_RDR;
            if(we) begin 
                we_uart = 1; we_ram = 0; we_led = 0;
            end
            else begin
                we_uart = 0; we_ram = 0; we_led = 0;
            end
        end
    end
end

endmodule
