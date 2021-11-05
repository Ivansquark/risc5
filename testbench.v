`timescale 1 ns / 100 ps


module testbench(); /* No inputs, no outputs */

reg clk = 1'b0; /* Represents clock, initial value is 0 */

always begin
    #1 clk = ~clk; /* Toggle clock every 1ns */
end

wire clk1; /* For output of tested module */

//rv_alu rv_alu(.clkin(clk), .clkout(clk1)); /* Tested module instance */

initial begin
    $dumpvars;      /* Open for dump of signals */
    $display("Test started...");   /* Write to console */
    #10 $finish;    /* Stop simulation after 10ns */
end

endmodule