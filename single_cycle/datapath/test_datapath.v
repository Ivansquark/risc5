`timescale 1ns/100ps

module test_datapath();

reg [31:0]instr;

reg clk=0;
reg reset=1;

reg [19:15]instr_A1=0;
reg [24:20]instr_A2=0;
reg [11:7]instr_A3=0;
reg [31:7]instr_imm=0;

reg [1:0]pc_src = 0;
reg reg_file_we3 = 0;
reg alu_src = 0;
reg [3:0]alu_ctrl=0;
reg [2:0]mem_ctrl=0;
reg [2:0]res_src=0;
reg [2:0]imm_src=0;

reg [31:0]ram_read_data=0;

wire [3:0]pc_out=0;
wire zero;
wire [31:0]alu_res=0;
wire [31:0]write_data=0;

datapath datapath1(.clk(clk), .reset(reset),
            .instr_A1(instr_A1), .instr_A2(instr_A2), .instr_A3(instr_A3), .instr_imm(instr_imm),
            .pc_src(pc_src), .alu_src(alu_src), .reg_file_we3(reg_file_we3), .alu_ctrl(alu_ctrl), 
            .mem_ctrl(mem_ctrl), .res_src(res_src), .imm_src(imm_src),
            .ram_read_data(ram_read_data),
            .zero(zero),
            .alu_res(alu_res), .write_data(write_data));

initial begin
    $dumpvars;
    $display("test started");
    #20;
    $finish();
end

initial begin
    instr = 32'h00000000;
    instr_A1 = instr[16:15];
    instr_A2 = instr[24:20];
    instr_A3 = instr[11:7];
    instr_imm = instr[31:7];

    #1;
    #8;
    instr = 32'h00000063;
    instr_A1 = instr[16:15];
    instr_A2 = instr[24:20];
    instr_A3 = instr[11:7];
    instr_imm = instr[31:7];

    pc_src = 2'b00;
    alu_src = 0;
    reg_file_we3 = 0;
    alu_ctrl = 1;
    mem_ctrl = 0;
    res_src = 0;
    imm_src = 3'b010;
    #2;
    pc_src = 2'b00;
end

always begin
    #1; clk = ~clk;
end

endmodule
