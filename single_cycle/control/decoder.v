`include "../rv_defs.v"

module decoder (
    input [6:0]op,
    input [14:12]funct3,
    input [31:25]funct7,
    input zero,

    output pc_src,
    output [1:0]res_src,
    output mem_we,
    output reg [3:0]alu_ctrl,
    output alu_src,
    output [2:0]imm_src,
    output reg_we
);

always @* begin
    case (op)
        `opcode_R: begin
            if(funct3 == 0) begin
                if(funct7 == 7'h00) alu_ctrl = `ALU_ADD;
                else if(funct7 == 7'h20) alu_ctrl = `ALU_SUB;
            end
            else if(funct3 == 3'h4) alu_ctrl = `ALU_XOR;
            else if(funct3 == 3'h06) alu_ctrl = `ALU_OR;
            else if(funct3 == 3'h07) alu_ctrl = `ALU_AND;
            else if(funct3 == 3'h01) alu_ctrl = `ALU_SLL;
            else if(funct3 == 3'h05) begin
                if(funct7 == 7'h00) alu_ctrl = `ALU_SRL;
                else if(funct7 == 7'h20) alu_ctrl = `ALU_SRA;
            end
            else if(funct3 == 3'h02) alu_ctrl = `ALU_SLT;
            else if(funct3 == 3'h03) alu_ctrl = `ALU_SLTU;
        end
    endcase
end

endmodule
