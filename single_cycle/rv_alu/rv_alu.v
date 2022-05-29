
/*
*************************************
**********   RISC-V ALU   *********** 
*************************************
*/
`include "../rv_defs.v"
module rv_alu( 
    input   [3:0]op_in,        
    input   [31:0]rs1,
    input   [31:0]rs2,
	output  [31:0]rd,
    output  zero    // zero
);
    reg [31:0]result_r;
    
    wire [31:0]sub_res;
	
    assign sub_res = rs1 - rs2;
    assign zero = (!sub_res) ? 1 : 0;

    always @ (*) begin
        case (op_in)
            ////////////    arithmetic  ////////////////////
            `ALU_ADD:   result_r = rs1 + rs2;  // non blocked (result in register)
            `ALU_SUB:   result_r = sub_res; //rs1 - rs2;
            ////////////    logical     ////////////////////
            `ALU_XOR:   result_r = rs1 ^ rs2;
            `ALU_OR:    result_r = rs1 | rs2;
            `ALU_AND:   result_r = rs1 & rs2;
            ////////////    shift       ////////////////////
            `ALU_SLL:   result_r = rs1 << (rs2 & 31); //max on 5
            `ALU_SRL:   result_r = rs1 >> (rs2 & 31);
            `ALU_SRA:   result_r = rs1 >>> (rs2 & 31);
                        
            ////////////    compare     ////////////////////
            //          slt : last bit if 1 => rd[0]=1 else rd=0)
            //          sltu : check for carry if 0 => rd[0] = 1 else rd[0]=0
            `ALU_SLT: begin
				if (rs1[31] != rs2[31])                         // check most significant bit
                    result_r  = rs1[31] ? 32'h1 : 32'h0;        // if rs1=0 => rs1<rs2 => true
                else
                    result_r  = sub_res[31] ? 32'h1 : 32'h0;    // 00 - 01 => 00 + 11 = 11 => true
             end
            `ALU_SLTU: begin
                result_r      = (rs1 < rs2) ? 32'h1 : 32'h0;
            end    
        endcase
	end
	//assign comp_res = result_r[0];
	assign rd = result_r;
endmodule 
