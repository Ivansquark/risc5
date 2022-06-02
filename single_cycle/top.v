`include "single_cycle/single_cycle.v"

module top(
    input clk,
    input enable,
    input reset
);

single_cycle processor0(
    clk, enable, reset
);

endmodule
