module alu_src_mux(
    input alu_src,
    input [31:0]rd2,
    input [31:0]imm_ext,
    output[31:0]alu_rs2
);

assign alu_rs2 = (alu_src) ? imm_ext : rd2;

endmodule
