`timescale 1 ns / 100 ps


module test_rv_alu(); /* No inputs, no outputs */

//reg clk = 1'b0; /* Represents clock, initial value is 0 */
reg [3:0]opcode;
reg [31:0]in1;
reg [31:0]in2;
//wire comp;
reg clk = 1'b0;

//reg [31:0]result;

always begin
    #0 clk = ~clk; /* Toggle clock every 1ns */
    #1 opcode = 1; // add
    in1 = 2;
    in2 = 1;    
end

wire clk1; /* For output of tested module */

rv_alu rv_alu(.op_in(opcode), .rs1(in1), .rs2(in2));//, .rd(result), .comp_res(comp)); /* Tested module instance */

initial begin
    $dumpvars;      /* Open for dump of signals (save in file)*/
    $display("Test started...");   /* Write to console */
    #10 $finish;    /* Stop simulation after 10ns */
end

endmodule
