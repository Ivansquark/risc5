module ram (
    #parameter N = 10;
) 
(
    input clk,
    input we,
    // 1024*32 bits = 1024*4 bytes = 4 Kb 
    input [N-1, 0]address, 
    input [31:0]data_in,
    output [31:0]data_out,
);

reg [31:0]mem[2**N-1];

always @(posedge clk) begin
    if (we) mem[address] <= data_in; 
    else data_out <= mem[address];
end

endmodule
