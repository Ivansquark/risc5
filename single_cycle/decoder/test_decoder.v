`timescale 1ns/100ps

`include "../rv_defs.v"
module test_decoder();

reg [31:0] instruction;
reg [6:0]opcode;
reg [14:12]funct3;
reg funct7;
reg zero;

decoder dec1(.op(opcode), .funct3(funct3), .funct7(funct7), .zero(zero));

initial begin
    $dumpvars;
    $display("start");
    #10 $finish();
end

initial begin
    zero = 0;
    #1;
    instruction = 32'h00000000;
    opcode = instruction[6:0];
    funct3 = instruction[14:12];
    funct7  = instruction[30];
    #1;
    instruction = 32'h00000063;
    opcode = instruction[6:0];
    funct3 = instruction[14:12];
    funct7  = instruction[30];
    zero = 1;
    #1;
    zero = 0;
    instruction = 32'h00C00193;
    opcode = instruction[6:0];
    funct3 = instruction[14:12];
    funct7  = instruction[30];
    #1;
    instruction = 32'hFF718393;
    opcode = instruction[6:0];
    funct3 = instruction[14:12];
    funct7  = instruction[30];
    #1;
    instruction = 32'h0023E233;
    opcode = instruction[6:0];
    funct3 = instruction[14:12];
    funct7  = instruction[30];
    #1;
    instruction = 32'h0041F2B3;
    opcode = instruction[6:0];
    funct3 = instruction[14:12];
    funct7  = instruction[30];
    #1;
    instruction = 32'h004282B3;
    opcode = instruction[6:0];
    funct3 = instruction[14:12];
    funct7  = instruction[30];
end

endmodule
