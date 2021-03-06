module reg_file(
    input           clk,
    input           we3,
    input   [4:0]   a1, a2, a3, //32 regs addresses
    input   [31:0]  wd3,
    output  reg [31:0]  rd1, rd2    
);

reg [31:0]rf[31:0]; //32 regs 32 bits

integer i;
initial begin
    for(i = 0; i<32; i = i + 1)
        rf[i] = 32'h00000000;
end

always @(posedge clk) begin
    if (we3) rf[a3] <= wd3;    
        
   // if(a1 !=0) rd1 <= rf[a1];
   // else rd1 <= 0;
   // if(a2 !=0) rd2 <= rf[a2];
   // else rd2 <= 0;    
end

always @* begin
    if(a1 !=0) rd1 = rf[a1];
    else rd1 = 0;
    if(a2 !=0) rd2 = rf[a2];
    else rd2 = 0; 
end
// reg[0] allways 0
endmodule
