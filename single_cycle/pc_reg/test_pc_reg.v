`timescale 1ns/100ps

module test_pc_reg();

reg clk=0;
reg reset=1;
reg [31:0] in;
wire [31:0] out;

pc_reg pc1(.clk(clk), .reset(reset), .pc_prev(in)); // if not all ports
//pc_reg pc1(clk, en, reset, in, out); // ports must be fully mapped 

initial begin
    $dumpvars;
    $display("start");
    #20;
    $finish();
end

initial begin
    in = 32'h00000000;
    #2;
    in = 32'h00000004;
    #2;
    in = 32'h00000008;
    #5;
end

always begin
    #1;
    clk = ~clk;
end

endmodule
