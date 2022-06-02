`include "single_cycle/single_cycle.v"

module top(
    input clk,
    input enable,
    input reset,
    output [31:0]single_reg
);

single_cycle processor0(
    clk, enable, reset, single_reg
);

endmodule
