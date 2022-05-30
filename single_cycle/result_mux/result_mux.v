`include "../rv_defs.v"
module result_mux(
    input [1:0] res_src,
    input [31:0]alu_res,
    input [31:0]mem,
    input [31:0]pc_plus4,
    output [31:0] res
);

always @* begin
    case(res_src)
        `RES_MPX_ALU: res = alu_res;
        `RES_MPX_MEM: res = mem;
        `RES_MPX_PC4: res = pc_plus4;
        default: res = alu_res;
    endcase 
end

endmodule
