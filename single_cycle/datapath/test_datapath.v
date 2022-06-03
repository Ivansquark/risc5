`timescale 1ns/100ps

module test_datapath();

reg clk=0;
reg reset=1;
reg [1:0]pc_src = 0;

datapath datapath1(.clk(clk), .reset(reset), .pc_src(pc_src));

initial begin
    $dumpvars;
    $display("test started");
    #10;
    $finish();
end

always begin
    #1; clk = ~clk;
end

endmodule
