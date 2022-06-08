`include "single_cycle/single_cycle.v"

module top(
    input clk,
    input reset,
    input rx,
    output tx,
    output [7:0]led_out
);

single_cycle processor0(
    clk, reset, rx,
    tx, led_out
);

endmodule
