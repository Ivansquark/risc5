module reg (
    input           clk,
    input           we3,
    input [4:0]     a1, a2, a3, //32 regs addresses
    input [31:0]    wd3,
    output          rd1, rd2    
);

reg [31:0] rf[31:0]; //32 regs 32 bits

always @(posedge clk)
    if (we3) rf[a3] <= wd3;
// reg[0] allways 0
assign rd1 = (a1 != 0) ? rf[a1] : 0;
assign rd2 = (a2 != 0) ? rf[a2] : 0;
endmodule
