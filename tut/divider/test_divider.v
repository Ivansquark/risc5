`timescale 1 ns / 100 ps

module test_divider ();

reg clk = 0;
reg [1:0]N = 0;

divider dut(.clk(clk), .N(N));

initial begin
    $dumpvars;
    #60 $finish;
end

initial begin
    #4  N = 1;
    #20 N = 2;
    #30 N = 3;
    #45 N = 2'b00;
end

always begin
    #1 clk = ~clk;
end

endmodule

