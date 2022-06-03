`include "../rv_defs.v"
module imm_sign_ext (
    input [2:0]imm_src,       
    input [31:7] instr,
    output reg [31:0] imm_out
);

always @* begin
    case (imm_src)
        // Immediate, load
        `IMM_I: imm_out = {{20{instr[31]}},    //31-12 
                                instr[31:20]};  //11-0
        // Store      
        `IMM_S: imm_out  = {{20{instr[31]}},   //31-12
                                instr[31:25],   //11-5
                                instr[11:7]};   //4-0
        // Branch
        `IMM_B: imm_out = {{20{instr[31]}},    //31-12  (imm[12]=instr[31])
                                instr[7],       //11
                                instr[30:25],   //10-5
                                instr[11:8],    //4-1
                                1'b0};             //0
        // Upper imediate
        `IMM_U: imm_out = {instr[31:12],       //31-12
                            {12{1'b0}}};        //11-0
        // Jalr (jump and link register)
        `IMM_J: imm_out = {{12{instr[31]}},    //31-20
                            instr[19:12],       //19-12
                            instr[20],          //11
                            instr[30:21], 1'b0};    //10-1 0
        default: imm_out = 0;
    endcase  
end

endmodule
