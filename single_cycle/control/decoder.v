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
    output [1:0]reg_we,
    output [2:0]mem_ctrl
);

always @* begin
    case (op)
        `opcode_R: begin
            res_src = RES_MPX_ALU;
            alu_src = ALU_MUX_REG_REG
            if(funct3 == 0) begin
                if(funct7 == 7'h00) alu_ctrl = `ALU_ADD;
                else if(funct7 == 7'h20) alu_ctrl = `ALU_SUB;
            end
            else if(funct3 == 3'h4) alu_ctrl = `ALU_XOR;
            else if(funct3 == 3'h6) alu_ctrl = `ALU_OR;
            else if(funct3 == 3'h7) alu_ctrl = `ALU_AND;
            else if(funct3 == 3'h1) alu_ctrl = `ALU_SLL;
            else if(funct3 == 3'h5) begin
                if(funct7 == 7'h00) alu_ctrl = `ALU_SRL;
                else if(funct7 == 7'h20) alu_ctrl = `ALU_SRA;
            end
            else if(funct3 == 3'h2) alu_ctrl = `ALU_SLT;
            else if(funct3 == 3'h3) alu_ctrl = `ALU_SLTU;
        end
        `opcode_Ia: begin
            res_src = RES_MPX_ALU;
            alu_src = ALU_MUX_REG_IMM;
            if(funct3 == 0)         alu_ctrl = `ALU_ADD;
            else if(funct3 == 3'h4) alu_ctrl = `ALU_XOR;
            else if(funct3 == 3'h6) alu_ctrl = `ALU_OR;
            else if(funct3 == 3'h7) alu_ctrl = `ALU_AND;
            else if(funct3 == 3'h1) alu_ctrl = `ALU_SLL;
            else if(funct3 == 3'h5) begin
                if(funct7 == 7'h00) alu_ctrl = `ALU_SRL;
                else if(funct7 == 7'h20) alu_ctrl = `ALU_SRA;
            end
            else if(funct3 == 3'h2) alu_ctrl = `ALU_SLT;
            else if(funct3 == 3'h3) alu_ctrl = `ALU_SLTU;
        end
        `opcode_Ib: begin
            mem_we      = 0;
            res_src     = `RES_MPX_MEM;
            alu_ctrl    = `ALU_ADD;
            alu_src     = `ALU_MUX_REG_IMM;
            case (funct3)
                `LOAD_B:    mem_ctrl = `LOAD_B;  
                `LOAD_HW:   mem_ctrl = `LOAD_HW;  
                `LOAD_W:    mem_ctrl = `LOAD_W;  
                `LOAD_BU:   mem_ctrl = `LOAD_BU;  
                `LOAD_HWU:  mem_ctrl = `LOAD_HWU;
                default:    mem_ctrl = `LOAD_W;
            endcase
        end
        `opcode_S: begin
            mem_we      = 1;
            alu_ctrl    = `ALU_ADD;
            alu_src     = `ALU_MUX_REG_IMM;
            case(funct3)
                `STORE_B:   mem_ctrl = `STORE_B;
                `STORE_HW:  mem_ctrl = `STORE_HW;
                `STORE_W:   mem_ctrl = `STORE_W;
                default:    mem_ctrl = `STORE_W;
            endcase
        end
        `opcode_B: begin
            alu_src = `ALU_MUX_REG_REG;
            case(funct3)
                3'h0: begin
                    alu_ctrl = `ALU_SUB;
                    pc_src = (zero) ? `PC_MUX_TARGET : `PC_MUX_PLUS4;
                end
                3'h1: begin
                    alu_ctrl = `ALU_SUB;
                    pc_src = (!zero) ? `PC_MUX_TARGET : `PC_MUX_PLUS4;
                end
                //TODO: < >= ...
            endcase
        end
    endcase
end

endmodule
