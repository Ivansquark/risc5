module pc_target_adder (
    input [31:0]pc_next,
    input [31:0]imm_ext,
    output [31:0]pc_target
);

assign pc_target = pc_next + imm_ext;

endmodule
