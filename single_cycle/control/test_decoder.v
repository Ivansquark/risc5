`timescale 1ns/100ps

`include "../rv_defs.v"
module test_decoder();

reg [6:0]opcode;
reg [14:12]funct3;
reg [31:25]funct7;

decoder dec1(.op(opcode), .funct3(funct3), .funct7(funct7));

initial begin
    $dumpvars;
    $display("start");
    #10 $finish();
end

initial begin
    #1 opcode = `opcode_R;
    #1 funct7 = 0;
    #1 funct3 = 0;
    #5 funct3 = 4;
end

endmodule
