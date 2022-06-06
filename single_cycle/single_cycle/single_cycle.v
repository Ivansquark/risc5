`include "../core/core.v"
`include "../rom/rom.v"
`include "../io_ram_datapath/io_ram_datapath.v"
//TODO: inputs firmware to rom; outputs to i/o system from ram
module single_cycle(
    //to core from top
    input clk,
    input reset,
    input rx,
    output [31:0]single_reg,
    output [7:0]led_out,
    output tx
);
//outputs
//core
wire [31:0]pc;              //to rom
wire ram_we;                //to ram
wire [1:0]mem_ctrl;         //to ram
wire [31:0]alu_res;         //to ram
wire [31:0]ram_write_data;  //to ram
//rom
wire [31:0]instr;           //to core
//ram
wire [31:0]ram_read_data;   //to core

core core0(
    clk, reset,     //from top
    instr,                  //from rom
    pc,                     //to rom
    ram_read_data,          //from ram
    ram_we, mem_ctrl,       //to ram
    alu_res, ram_write_data //to ram
);

rom rom0(
    pc,                     //from core
    instr                   //to core
);

io_ram_datapath io_ram_datapath0(
    clk, alu_res, ram_write_data, ram_we, mem_ctrl, rx,
    ram_read_data, led_out, tx
);

//ram ram0(
//    clk,                                        //from top
//    ram_we, mem_ctrl, alu_res, ram_write_data,  //from core
//    ram_read_data,                              //to core and in future to i/o
//   single_reg
//);

endmodule
