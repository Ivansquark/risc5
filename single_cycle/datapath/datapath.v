`include "../pc_mux/pc_mux.v"
`include "../pc_reg/pc_reg.v"
`include "../reg_file/reg_file.v"
`include "../alu_src_mux/alu_src_mux.v"
`include "../rv_alu/rv_alu.v"
`include "../load_module/load_module.v"
`include "../result_mux/result_mux.v"
`include "../pc_plus4_adder/pc_plus4_adder.v"
`include "../imm_sign_ext/imm_sign_ext.v"
`include "../pc_target_adder/pc_target_adder.v"
module datapath(
    //------ inputs from core --------
    input clk,              // pc_reg
    input reset,
    //******    decoder     **********
    //------ inputs from decoder -----
    input [1:0]pc_src,      // pc_mux:
    input reg_file_we3,     // reg_file
    input alu_src,          // alu_src_mux
    input [3:0]alu_ctrl,    // alu
    input [2:0]mem_ctrl,    // mem load module
    input [2:0]res_src,     // result mux
    input [2:0]imm_src,     // imm extender
    //------ outputs to decoder ------
    output zero,            // alu
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
    input [31:0]ram_read_data,
    //------ outputs to ram ----------
    output [31:0]alu_res,       //alu
    output [31:0]write_data     //reg_file
);
//--- internal wires (only output from internal modules) ---
// pc_mux
wire [31:0]pc_next; //to pc_reg
// pc_reg
wire [31:0]pc; // to output, to pc_plus4_adder, to pc_target, to pc_mux::pc_prev;
// reg_file
wire [31:0]rd1; //to alu rs1
wire [31:0]rd2; //to alu_src_mux, to output to ram write_data
// alu_src_mux
wire [31:0]rs2;
// alu
wire [31:0]alu_res_internal; //to ram A, to pc_mux::pc_alu, to result_mux::res_alu
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

assign pc_out = pc;
assign write_data = rd2;
assign alu_res = alu_res_internal; 


pc_mux pc_mux0(pc_src, pc_plus4, pc_target, alu_res_internal, pc, pc_next);
pc_reg pc_reg0(clk, reset, pc_next, pc);
reg_file regfile0(clk, reg_file_we3, instr_A1, instr_A2, instr_A3, res_res, rd1, rd2);
alu_src_mux alu_src_mux0(alu_src, rd2, imm_ext, rs2);
rv_alu rv_alu0(alu_ctrl, rd1, rs2, alu_res_internal, zero);

wire [1:0]low_ram_address = alu_res[1:0];
load_module load_module0(mem_ctrl, low_ram_address, ram_read_data, load_module_out);

result_mux result_mux0(res_src, alu_res, load_module_out, pc_plus4, imm_ext, pc_target, res_res);
pc_plus4_adder pc_plus4_adder0(pc, pc_plus4);
pc_target_adder pc_target_adder0(pc, imm_ext, pc_target);
imm_sign_ext imm_sign_ext0(imm_src, instr_imm, imm_ext);

endmodule
