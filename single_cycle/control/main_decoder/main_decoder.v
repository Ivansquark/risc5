module main_decoder (
    input wire [6:0] op,
    input wire [14:12]funct3,
    input wire funct7,
    output [3:0] alu_ctrl,
    output pc_src,
    output mem_write,
    output alu_src,
    output result_src,
    output [1:0] Imm_src,
    output reg_write,
    ...
);

endmodule
