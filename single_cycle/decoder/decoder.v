`include "../rv_defs.v"

module decoder (
    input [6:0]op,
    input [14:12]funct3,
    input funct7,
    input zero,

    output reg [1:0]pc_src,
    output reg [2:0]res_src,
    output reg reg_file_we,
    output reg mem_we,
    output reg [3:0]alu_ctrl,
    output reg alu_src,
    output reg [2:0]imm_src,
    output reg [2:0]mem_ctrl
);

always @* begin
    pc_src      = 0;
    res_src     = 0;
    reg_file_we = 0;
    mem_we      = 0;
    alu_ctrl    = 0;
    alu_src     = 0;
    imm_src     = 0;
    mem_ctrl    = 0;
    case (op)
        // register - register; rd = rs1 + rs2...
        `OP_R: begin
            reg_file_we = 1;
            mem_we = 0;
            res_src = `RES_MUX_ALU;
            alu_src = `ALU_MUX_REG_REG;
            if(funct3 == 0) begin
                if(funct7 == 1'b0) alu_ctrl = `ALU_ADD;
                else if(funct7 == 1'b1) alu_ctrl = `ALU_SUB;
            end
            else if(funct3 == 3'h4) alu_ctrl = `ALU_XOR;
            else if(funct3 == 3'h6) alu_ctrl = `ALU_OR;
            else if(funct3 == 3'h7) alu_ctrl = `ALU_AND;
            else if(funct3 == 3'h1) alu_ctrl = `ALU_SLL;
            else if(funct3 == 3'h5) begin
                if(funct7 == 1'b0) alu_ctrl = `ALU_SRL;
                else if(funct7 == 1'b1) alu_ctrl = `ALU_SRA;
            end
            else if(funct3 == 3'h2) alu_ctrl = `ALU_SLT;
            else if(funct3 == 3'h3) alu_ctrl = `ALU_SLTU;
        end
        // register - immediate; rd = rs1 + imm...
        `OP_I_ALU: begin
            reg_file_we = 1;
            mem_we = 0;
            res_src = `RES_MUX_ALU;
            alu_src = `ALU_MUX_REG_IMM;
            imm_src = `IMM_I;
            if(funct3 == 0)         alu_ctrl = `ALU_ADD;
            else if(funct3 == 3'h4) alu_ctrl = `ALU_XOR;
            else if(funct3 == 3'h6) alu_ctrl = `ALU_OR;
            else if(funct3 == 3'h7) alu_ctrl = `ALU_AND;
            else if(funct3 == 3'h1) alu_ctrl = `ALU_SLL;
            else if(funct3 == 3'h5) begin
                if(funct7 == 1'b0) alu_ctrl = `ALU_SRL;
                else if(funct7 == 1'b1) alu_ctrl = `ALU_SRA;
            end
            else if(funct3 == 3'h2) alu_ctrl = `ALU_SLT;
            else if(funct3 == 3'h3) alu_ctrl = `ALU_SLTU;
        end
        // load from memory; rd = M[rs1+imm]
        `OP_I_LOAD: begin
            reg_file_we = 1;
            mem_we      = 0;
            res_src     = `RES_MUX_MEM;
            alu_ctrl    = `ALU_ADD;
            alu_src     = `ALU_MUX_REG_IMM;
            imm_src     = `IMM_I;
            case (funct3)
                `LOAD_B:    mem_ctrl = `LOAD_B;  
                `LOAD_HW:   mem_ctrl = `LOAD_HW;  
                `LOAD_W:    mem_ctrl = `LOAD_W;  
                `LOAD_BU:   mem_ctrl = `LOAD_BU;  
                `LOAD_HWU:  mem_ctrl = `LOAD_HWU;
                default:    mem_ctrl = `LOAD_W;
            endcase
        end
        // store to memory; M[rs1+imm] = rs2; (+mem load module after ram)
        `OP_S: begin
            reg_file_we = 0;
            mem_we      = 1;
            alu_ctrl    = `ALU_ADD;
            alu_src     = `ALU_MUX_REG_IMM;
            imm_src     = `IMM_S;
            case(funct3)
                `STORE_B:   mem_ctrl = `STORE_B;
                `STORE_HW:  mem_ctrl = `STORE_HW;
                `STORE_W:   mem_ctrl = `STORE_W;
                default:    mem_ctrl = `STORE_W;
            endcase
        end
        // branch
        `OP_B: begin
            reg_file_we = 0;
            mem_we = 0;
            alu_src = `ALU_MUX_REG_REG;
            imm_src = `IMM_B;
            case(funct3)
                // rs1 == rs2
                3'h0: begin
                    alu_ctrl = `ALU_SUB;
                    pc_src = (zero) ? `PC_MUX_TARGET : `PC_MUX_PLUS4;
                end
                // rs1 != rs2
                3'h1: begin
                    alu_ctrl = `ALU_SUB;
                    pc_src = (!zero) ? `PC_MUX_TARGET : `PC_MUX_PLUS4;
                end
                // rs1 < rs2 signed
                3'h4: begin
                    alu_ctrl = `ALU_SLT;
                    pc_src = (zero) ? `PC_MUX_TARGET : `PC_MUX_PLUS4;
                end
                // rs1 >= rs2 signed
                3'h5: begin
                    alu_ctrl = `ALU_SLT;
                    pc_src = (!zero) ? `PC_MUX_TARGET : `PC_MUX_PLUS4;
                end
                // rs1 < rs2 unsigned
                3'h6: begin
                    alu_ctrl = `ALU_SLTU;
                    pc_src = (zero) ? `PC_MUX_TARGET : `PC_MUX_PLUS4;
                end
                // rs1 >= rs2 unsigned
                3'h7: begin
                    alu_ctrl = `ALU_SLTU;
                    pc_src = (!zero) ? `PC_MUX_TARGET : `PC_MUX_PLUS4;
                end
                default: begin
                    alu_ctrl = `ALU_SUB;
                    pc_src = (zero) ? `PC_MUX_TARGET : `PC_MUX_PLUS4;
                end
            endcase
        end
        // jump and link; rd = PC+4; PC += immJ
        `OP_J_JAL: begin
            reg_file_we = 1;
            mem_we = 0;
            res_src = `RES_MUX_PC4; // rd = PC + 4
            imm_src = `IMM_J;
            pc_src = `PC_MUX_TARGET;    //PC += imm
        end
        // jump and link reg; rd = PC+4; PC = rs1 + immI
        `OP_J_JALR: begin
            reg_file_we = 1;
            mem_we = 0;
            res_src = `RES_MUX_PC4; // rd = PC + 4
            imm_src = `IMM_I;
            alu_src = `ALU_MUX_REG_IMM;
            alu_ctrl = `ALU_ADD;
            pc_src = `PC_MUX_ALU;   // PC = rs1 + immI;
        end
        // load upper immediate; rd = imm << 12
        `OP_U_LUI: begin
            reg_file_we = 1;
            mem_we = 0;
            imm_src = `IMM_U;
            res_src = `RES_MUX_LUI;
        end
        // auipc Add Upper Imm to PC; rd = PC + (imm << 12)
        `OP_U_AUIPC: begin
            reg_file_we = 1;
            mem_we = 0;
            imm_src = `IMM_U;
            res_src = `RES_MUX_AUI;
        end
        // ebreak Enviroment Break (transfer control to debugger)
        `OP_E_BREAK: pc_src = `PC_MUX_BREAK;
        default: pc_src = `PC_MUX_BREAK;
    endcase
end

endmodule
