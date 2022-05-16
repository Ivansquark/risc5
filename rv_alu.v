
/*
*************************************
**********   RISC-V ALU   *********** 
*************************************
*/
//              FROM main decoder TODO: remove this to definition file and bind to MainDecoder
`define ALU_ADD      4'b0000     //  rd = rs1 + rs2;        add
`define ALU_SUB      4'b0001     //  rd = rs1 - rs2;        sub
`define ALU_XOR      4'b0010     //  rd = rs1 ^ rs2;        exclusively or
`define ALU_OR       4'b0011     //  rd = rs1 | rs2;        or
`define ALU_AND      4'b0100     //  rd = rs1 & rs2;        and
`define ALU_SLL      4'b0101     //  rd = rs1 <<< rs2;      shift left logical
`define ALU_SRL      4'b0111     //  rd = rs1 >>> rs2;      shift right logical     (1011 >> 1 == 0101)
`define ALU_SRA      4'b1000     //  rd = rs1 >> rs2;       shift right ariphmetic  (1011 >> 1 == 1101)
`define ALU_SLT      4'b1001     //  rd = rs1 < rs2;        set rd=1 if less than           (0xFF<0 true) 
`define ALU_SLTU     4'b1010     //  rd = rs1 < rs2;        set rd=1 if less than unsigned  (0xFF<0 false)
// import rv_defs.v

module rv_alu( 
    input   [3:0]op_in,        
    input   [31:0]rs1,
    input   [31:0]rs2,
	output  [31:0]rd,
    output  comp_res
);
    reg [31:0]result_r;
    
    wire [31:0]sub_res;
	 assign sub_res = rs1 - rs2;
    always @ (*) begin
        case (op_in)
            ////////////    arithmetic  ////////////////////
            `ALU_ADD:    result_r <= rs1 + rs2;  // non blocked (result in register)
            `ALU_SUB:    result_r <= sub_res; //rs1 - rs2;
            ////////////    logical     ////////////////////
            `ALU_XOR:    result_r <= rs1 ^ rs2;
            `ALU_OR:     result_r <= rs1 | rs2;
            `ALU_AND:    result_r <= rs1 & rs2;
            ////////////    shift       ////////////////////
            `ALU_SLL:    result_r <= rs1 << (rs2 & 31);
            `ALU_SRL:    result_r <= rs1 >> (rs2 & 31);
            `ALU_SRA:    result_r <= rs1 >>> (rs2 & 31);
            ////////////    compare     ////////////////////
            `ALU_SLT: begin
					if (rs1[31] != rs2[31])                         // check most significant bit
                    result_r  <= rs1[31] ? 32'h1 : 32'h0;        // if rs1=0 => rs1<rs2 => true
                else
                    result_r  <= sub_res[31] ? 32'h1 : 32'h0;    // 00 - 01 => 00 + 11 = 11 => true
             end
            `ALU_SLTU: begin
                result_r      <= (rs1 < rs2) ? 32'h1 : 32'h0;
            end    
        endcase
	end
	assign comp_res = result_r[0];
	assign rd = result_r;
endmodule 
