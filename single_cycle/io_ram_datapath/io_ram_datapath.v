`include "../io_ram_decoder/io_ram_decoder.v"
`include "../led/led.v"
`include "../uart/uart.v"
`include "../ram/ram.v"
`include "../load_mux/load_mux.v"

module io_ram_datapath(
    input clk,
    input [31:0]address,
    input [31:0]wd,
    input we,
    input [2:0]mem_ctrl,
    input rx,
    output [31:0]rd,
    output [7:0]led_out,
    output tx
);

wire we_ram;
wire we_uart;
wire we_led;
wire [31:0] address_to_ram;
wire [2:0]uart_reg_mux_out;
wire load_mux;
wire [31:0]rd_uart;
wire [31:0]rd_ram;

reg [3:0]mem_wmask;
reg [31:0]wd_out;

always @* begin
    if(we) begin
        case(mem_ctrl)
            `STORE_B: begin 
                case(address[1:0]) 
                    2'b00: begin
                        mem_wmask = 4'b0001;
                        wd_out = wd;
                    end
                    2'b01: begin 
                        mem_wmask = 4'b0010;
                        wd_out = {{16{1'b0}}, wd[7:0], {8{1'b0}}};
                    end
                    2'b10: begin
                        mem_wmask = 4'b0100;
                        wd_out = {{8{1'b0}}, wd[7:0], {16{1'b0}}};
                    end
                    2'b11: begin
                        mem_wmask = 4'b1000;
                        wd_out = {wd[7:0], {24{1'b0}}};
                    end
                endcase                
            end
            `STORE_HW: begin
                case(address[1:0]) 
                    2'b00: begin
                        mem_wmask = 4'b0011;
                        wd_out = wd;
                    end
                    2'b01: begin
                        mem_wmask = 4'b0110;
                        wd_out = {{8{1'b0}}, wd[15:0], {8{1'b0}}};
                    end
                    2'b10: begin
                        mem_wmask = 4'b1100;
                        wd_out = {wd[15:0], {16{1'b0}}};
                    end
                    2'b11: begin
                        mem_wmask = 4'b1111;
                        wd_out = wd;
                    end
                endcase                
            end
            `STORE_W: begin
                mem_wmask = 4'b1111;
                wd_out = wd;
            end
            default: begin
                mem_wmask = 4'b1111;
                wd_out = wd;
            end
        endcase
    end
    else begin
        mem_wmask = 4'b0000;
        wd_out = wd;
    end
end

io_ram_decoder io_ram_decoder0(
    address,we,
    address_to_ram, we_ram, we_uart, we_led, uart_reg_mux_out, load_mux
);

led led0(
    we_led,
    wd[7:0],
    led_out);

uart uart0(
    we_uart, clk, uart_reg_mux_out, wd, rx,      //inputs
    rd_uart, tx                             //outputs
);

ram ram0(
    clk, mem_wmask, address_to_ram, wd_out, 
    rd_ram
);

load_mux load_mux0(
    load_mux, rd_ram, rd_uart,
    rd
);

endmodule
