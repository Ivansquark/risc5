`timescale 1ns/100ps

module test_datapath();

reg clk=0;
reg en=0;
reg reset=0;

datapath datapath1(.clk(clk), .en(en), .reset(reset));

initial begin
    $dumpvars;
    $display("test started");
    #10;
    $finish();
end

endmodule
