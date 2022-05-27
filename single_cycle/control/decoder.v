`define opcode_R    0'b0110011
`define opcode_Ia   0'b0010011
`define opcode_Ib   0'b0000011
`define opcode_S    0'b0100011
`define opcode_B    0'b1100011
`define opcode_Ul   0'b0110111
`define opcode_Ui   0'b0010111
`define opcode_J    0'b1101111
`define opcode_Ij   0'b1100111
`define opcode_Ec   0'b1110011
`define opcode_Eb   0'b0110011

module decoder (
    input [6:0]op,
    input [14:12]funct3,
    input [31:25]funct7,
    input zero,

    output pc_src,
    output [1:0]res_src,
    output mem_we,
    output [3:0]alu_ctrl,
    output alu_src,
    output [2:0]imm_src,
    output reg_we
);

always @* begin
    case (op)

end

endmodule;
