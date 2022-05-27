module result_mux(
    input [1:0] res_src,
    input [31:0]alu_res,
    input [31:0]mem,
    input [31:0]pc_plus4,
    output [31:0] res
);

always @* begin
    case(res_src)
        2'b00: res = alu_res;
        2'b01: res = mem;
        2'b10: res = pc_plus4;
        default: res = alu_res;
    endcase 
end

endmodule
