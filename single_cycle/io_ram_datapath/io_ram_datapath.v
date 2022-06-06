`include "../io_ram_decoder/io_ram_decoder.v"
`include "../led/led.v"
`include "../uart/uart.v"
`include "../ram/ram.v"
`include "../load_mux"

module io_ram_datapath(
    input clk,
    input [31:0]address,
    input [31:0]wd,
    input we,
    input [1:0]mem_ctrl,
    input rx,
    output [31:0]rd,
    output [7:0]led_out,
    output tx,
);

wire we_ram;
wire we_uart;
wire we_led;
wire [31:0] address_to_ram;
wire [2:0]uart_reg_mux_out;
wire load_mux;
wire rd_uart;
wire rd_ram;

io_ram_decoder io_ram_decoder0(
    address,we,
    address_to_ram, we_ram, we_uart, we_led, uart_reg_mux_out, load_mux
);

led led0(
    we_led,
    led_out);

uart uart0(
    we_uart, clk, uart_reg_mux_out, wd, rx,      //inputs
    rd_uart, tx                             //outputs
);

ram ram0(
    clk, we_ram, mem_ctrl, address_to_ram, wd, 
    rd_ram
);

load_mux load_mux0(
    load_mux, rd_ram, rd_uart,
    rd
);

endmodule
