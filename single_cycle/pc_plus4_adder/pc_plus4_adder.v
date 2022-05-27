module pc_plus4_adder(
    input [31:0]pc_next,
    output [31:0]pc_prev
);

assign pc_prev = pc_next + 4;

endmodule
