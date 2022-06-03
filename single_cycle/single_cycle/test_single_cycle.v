`timescale 1ns/100ps

module test_single_cycle();

reg clk;
reg reset;

single_cycle processor0(.clk(clk), .reset(reset));

initial begin
    $dumpvars;
    $display("test started");
    #20;
    $finish();
end

initial begin
    clk = 0;
    reset = 1;
end

always begin
    #1;
    clk = ~clk;
end 

endmodule
