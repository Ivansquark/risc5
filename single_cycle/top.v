`include "single_cycle/single_cycle.v"

module top(
    input clk,
    input reset,
    output [31:0]single_reg
);

single_cycle processor0(
    clk, reset, single_reg
);

endmodule
