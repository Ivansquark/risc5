`timescale 1ns/100ps

module test_ext();

reg [2:0]imm_src;
reg [31:0] instruction;

imm_sign_ext imm(.imm_src(imm_src), .instr(instruction[31:7]));

initial begin
    $dumpvars;
    $display("start");
    #10 $finish();
end

initial begin
    #1 imm_src = 0;
    #1 instruction = 32'hFFFFFFFF;
end

endmodule
