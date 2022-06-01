`timescale 1ns/100ps

module test_pc_reg();

reg en;
reg clk;
reg [31:0] in;

pc_reg pc1(.en(en), .clk(clk), .pc_prev(in));

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
