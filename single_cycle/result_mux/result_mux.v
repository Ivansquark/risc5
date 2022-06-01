`include "../rv_defs.v"
module result_mux(
    input [2:0] res_src,
    input [31:0]alu_res,
    input [31:0]mem,
    input [31:0]pc_plus4,
    input [31:0]imm_lui,
    input [31:0]imm_auipc,
    output reg [31:0] res
);

always @* begin
    case(res_src)
        `RES_MUX_ALU: res = alu_res;
        `RES_MUX_MEM: res = mem;
        `RES_MUX_PC4: res = pc_plus4;
        `RES_MUX_LUI: res = imm_lui;
        `RES_MUX_AUI: res = imm_auipc;
        default: res = alu_res;
    endcase 
end

endmodule
