`define I_type 0 // [11:0]imm(31-20)
`define S_type 1 // [11:5]imm(31-24) and [4:0]imm(11-7)
`define B_type 2 // [12]imm(31) [11]imm(7) [10:5]imm(30-25) [4:1]imm(11-8)
`define U_type 3 // [31:12]imm(31-12)
`define J_type 4 // [20]imm(31) [19:12]imm(19-12) [11]imm(20) [10:1]imm(30-21)

module imm_sign_ext (
    input [2:0]imm_src,       
    input [31:7] instr,
    output reg [31:0] imm_out
);

always @* begin
    case (imm_src)
        // Immediate
        `I_type: imm_out = {{20{instr[31]}},    //31-12 
                                instr[31:20]};  //11-0
        // Store - load
        `S_type: imm_out  = {{20{instr[31]}},   //31-12
                                instr[31:25],   //11-5
                                instr[11:7]};   //4-0
        // Branch
        `B_type: imm_out = {{20{instr[31]}},    //31-12  (imm[12]=instr[31])
                                instr[7],       //11
                                instr[30:25],   //10-5
                                instr[11:8],    //4-1
                                1'b0};             //0
        // Upper imediate
        `U_type: imm_out = {instr[31:12],       //31-12
                            {12{1'b0}}};        //11-0
        // Jalr (jump and link register)
        `J_type: imm_out = {{12{instr[31]}},    //31-20
                            instr[19:12],       //19-12
                            instr[20],          //11
                            instr[30:21], 1'b0};    //10-1 0
        default: imm_out = 32'bx;
    endcase  
end

endmodule
