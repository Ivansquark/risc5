`timescale 1ns/100ps

module test_pc_reg();

reg clk;
reg en;
reg reset;
reg [31:0] in;
wire [31:0] out;

pc_reg pc1(.clk(clk), .en(en), .pc_prev(in)); // if not all ports
//pc_reg pc1(clk, en, reset, in, out); // ports must be fully mapped 

initial begin
    $dumpvars;
    $display("start");
    #20;
    $finish();
end

initial begin
    clk=0;
    en=1;
    in = 32'h00000000;
    #3;
    in = 32'h00000001;
    en=0;
    #2;
    en=1;
    #2;
    in = 32'h00000002;
    en=0;
    #5;
    en=1;
end

always begin
    #1;
    clk = ~clk;
end

endmodule
