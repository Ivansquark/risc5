`include "../rv_defs.v"

module pc_mux(
    input [1:0]pc_src,
    input [31:0]pc_plus4,
    input [31:0]pc_target,
    input [31:0]pc_alu,
    input [31:0]pc_prev,
    output reg [31:0]pc_next
);

always @* begin
    case(pc_src)
        `PC_MUX_PLUS4:  pc_next = pc_plus4;
        `PC_MUX_TARGET: pc_next = pc_target;
        `PC_MUX_ALU:    pc_next = pc_alu;
        `PC_MUX_BREAK:  pc_next = pc_prev;
    endcase
end

endmodule
