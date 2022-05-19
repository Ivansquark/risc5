//`include "divide_by3FSM.sv"
`timescale 1ns / 100ps

module test_divide_by3FSM ();

logic clk;
logic reset;
divide_by3FSM fsm(.clk(clk), .reset(reset));

initial begin 
    $dumpvars();
    $display("start");
    #0 clk = 0;
    #0 reset = 0;
    #20 $finish();
end

always begin
    #1 clk = ~clk;
end

endmodule

