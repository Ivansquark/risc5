//opcodes for decoder
`define OP_R        7'b0110011
`define OP_I_ALU    7'b0010011
`define OP_I_LOAD   7'b0000011
`define OP_S        7'b0100011
`define OP_B        7'b1100011
`define OP_J_JAL    7'b1101111
`define OP_J_JALR   7'b1100111
`define OP_U_LUI    7'b0110111
`define OP_U_AUIPC  7'b0010111
`define OP_E_BREAK  7'b1110011

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
`define RES_MUX_ALU 3'b000
`define RES_MUX_MEM 3'b001
`define RES_MUX_PC4 3'b010
`define RES_MUX_LUI 3'b011
`define RES_MUX_AUI 3'b100

`define IMM_I 3'h0 // [11:0]imm(31-20)
`define IMM_S 3'h1 // [11:5]imm(31-24) and [4:0]imm(11-7)
`define IMM_B 3'h2 // [12]imm(31) [11]imm(7) [10:5]imm(30-25) [4:1]imm(11-8)
`define IMM_U 3'h3 // [31:12]imm(31-12)
`define IMM_J 3'h4 // [20]imm(31) [19:12]imm(19-12) [11]imm(20) [10:1]imm(30-21)


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
`define PC_MUX_PLUS4    2'b00
`define PC_MUX_TARGET   2'b01
`define PC_MUX_ALU      2'b10
`define PC_MUX_BREAK    2'b11
