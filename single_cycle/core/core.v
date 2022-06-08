`include "../decoder/decoder.v"
`include "../datapath/datapath.v"
module core(
    // from single_cycle
    input clk,
    input reset,
    //-----     rom     ------
    input [31:0]instr,  //to decoder and datapath
    output [31:0]pc,    //from datapath
    //-----     ram     ------
    input [31:0]ram_read_data,  //to datapath
    output ram_we,              //from decoder
    output [1:0]mem_ctrl,       //from decoder
    output [31:0]alu_res,       //from datapath
    output [31:0]ram_write_data //from datapath
);

// from rom to decoder
wire [6:0]instr_op      = instr[6:0];
wire [14:12]instr_funct3 = instr[14:12];
wire instr_funct7        = instr[30];
// from rom to datapath
wire [19:15]instr_A1    = instr[19:15];
wire [24:20]instr_A2    = instr[24:20];
wire [11:7]instr_A3     = instr[11:7];
wire [31:7]instr_imm    = instr[31:7];

//from decoder to datapath
wire [1:0]pc_src;
wire reg_file_we;
wire alu_src;
wire [3:0]alu_ctrl;
wire [2:0]mem_ctrl_from_decoder;
wire [2:0]res_src;
wire [2:0]imm_src;
//from datapath to decoder
wire zero;

assign mem_ctrl = mem_ctrl_from_decoder[1:0];

decoder decoder0(
    .op(instr_op), 
    .funct3(instr_funct3), .funct7(instr_funct7),
    .zero(zero),                                               //input
    .pc_src(pc_src),
    .res_src(res_src), .reg_file_we(reg_file_we),
    .mem_we(ram_we), .alu_ctrl(alu_ctrl), .alu_src(alu_src),
    .imm_src(imm_src), .mem_ctrl(mem_ctrl_from_decoder) //output
);

datapath datapath0(
    clk, reset,                                 //inputs from core
    pc_src, reg_file_we, alu_src, alu_ctrl,     //inputs from decoder
    mem_ctrl_from_decoder, res_src, imm_src,    //inputs from decoder
    zero,                                       //output to decoder
    instr_A1, instr_A2, instr_A3, instr_imm,    //inputs from rom
    pc,                                         //output to rom
    ram_read_data,                              //input from ram
    alu_res, ram_write_data                     //outputs to ram
);

endmodule
