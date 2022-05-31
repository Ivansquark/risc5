//opcodes for decoder
`define opcode_R    7'b0110011
`define opcode_Ia   7'b0010011
`define opcode_Ib   7'b0000011
`define opcode_S    7'b0100011
`define opcode_B    7'b1100011
`define opcode_Ul   7'b0110111
`define opcode_Ui   7'b0010111
`define opcode_J    7'b1101111
`define opcode_Ij   7'b1100111
`define opcode_Ec   7'b1110011
`define opcode_Eb   7'b0110011

// for rv_alu
`define ALU_ADD      4'b0000     //  rd = rs1 + rs2;        add
`define ALU_SUB      4'b0001     //  rd = rs1 - rs2;        sub //set zero output
`define ALU_XOR      4'b0010     //  rd = rs1 ^ rs2;        exclusively or
`define ALU_OR       4'b0011     //  rd = rs1 | rs2;        or
`define ALU_AND      4'b0100     //  rd = rs1 & rs2;        and
`define ALU_SLL      4'b0101     //  rd = rs1 <<< rs2;      shift left logical
`define ALU_SRL      4'b0110     //  rd = rs1 >>> rs2;      shift right logical     (1011 >> 1 == 0101)
`define ALU_SRA      4'b0111     //  rd = rs1 >> rs2;       shift right ariphmetic  (1011 >> 1 == 1101)

`define ALU_SLT      4'b1000     //  rd = rs1 < rs2;        set rd=1 if less than           (0xFF<0 true) 
`define ALU_SLTU     4'b1001     //  rd = rs1 < rs2;        set rd=1 if less than unsigned  (0xFF<0 false)

// alu_rs2 multiplexer
`define ALU_MUX_REG_REG 1'b0
`define ALU_MUX_REG_IMM 1'b1

// result multiplexer
`define RES_MPX_ALU 2'b00
`define RES_MPX_MEM 2'b01
`define RES_MPX_PC4 2'b10

// load module
`define LOAD_B      3'b000
`define LOAD_HW     3'b001
`define LOAD_W      3'b010
`define LOAD_BU     3'b011
`define LOAD_HWU    3'b100
// ram
`define STORE_B     2'b00
`define STORE_HW    2'b01
`define STORE_W     2'b10
// pc_mux
`define PC_MUX_PLUS4    0
`define PC_MUX_TARGET   1

