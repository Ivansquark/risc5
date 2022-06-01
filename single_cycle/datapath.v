`include "pc_mux/pc_mux.v"
`include "pc_reg/pc_reg.v"
`include "reg_file/reg_file.v"
`include "alu_src_mux/alu_src_mux.v"
`include "rv_alu/rv_alu.v"
`include "load_module/load_module.v"
`include "result_mux/result_mux.v"
`include "pc_plus4_adder/pc_plus4_adder.v"
`include "imm_sign_ext/imm_sign_ext.v"
`include "pc_target_adder/pc_target_adder.v"
module datapath(
    //------ inputs from core --------
    // pc_reg
    input clk,
    input en,
    input reset,
    //******    decoder     **********
    //------ inputs from decoder -----
    // pc_mux:
    input [1:0]pc_src,
    // reg_file
    input reg_file_we3,
    // alu_src_mux
    input alu_src,
    // alu
    input alu_ctrl,
    // mem load module
    input [2:0]mem_ctrl,
    // result mux
    input [2:0]res_src,
    // imm extender
    input [2:0]imm_src,
    //------ outputs to decoder ------
    output zero,
    //******    rom     **************
    //------ inputs from rom ---------
    input [19:15] instr_A1,
    input [24:20] instr_A2,
    input [11:7] instr_A3,
    input [31:7]instr_imm,
    //------ outputs to rom ----------
    output [31:0] pc_out,
    //******    ram     **************
    //------ inputs from ram ---------
    input [31:0]read_data,
    //------ outputs to ram ----------
    output [31:0]alu_res,
    output [31:0]write_data
);
// internal wires (only output from internal modules)
// pc_mux
wire [31:0]pc_target;
wire [31:0]pc_next; //to pc_reg
// pc_reg
wire [31:0]pc; // to output, to pc_plus4_adder, to pc_target, to pc_mux::pc_prev;
// reg_file
wire [31:0]rd1; //to alu rs1
wire [31:0]rd2; //to alu_src_mux, to output to ram write_data
// alu_src_mux
wire [31:0]rs2;
// alu
wire [31:0]alu_res; //to ram A, to pc_mux::pc_alu, to result_mux::res_alu
// load_module
wire [31:0]load_module_out; //to result_mux::mem
// result_mux
wire [31:0]res_res; //to reg_file::wd3
// pc_plus4_adder
wire [31:0]pc_plus4; //to pc_mux::pc_plus4, to result_mux::pc_plus4
// pc_target_adder
wire [31:0]pc_target; //to pc_mux::pc_target, to result_mux::auipc
// imm_sign_ext
wire [31:0]imm_ext; //to alu_src_mux::imm_ext, to result_mux::lui, to pc_target_adder::imm_ext;

pc_reg pc_reg1();

endmodule
