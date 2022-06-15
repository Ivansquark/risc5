`include "../rv_defs.v"
module ram (
    input             clk,   we,
    input       [3:0] be,           // 4 bytes per word
    input      [31:0] waddr, raddr, // address width = 6
    input      [31:0] wdata,        // byte width = 8, 4 bytes per word
    output reg [31:0] q             // byte width = 8, 4 bytes per word
);
// use a multi-dimensional packed array
// to model individual bytes within the word
logic [3:0][7:0] mem[0:127];
// # words = 1 << address width
// port A
always@(posedge clk) begin
    if(we) begin
        //for (int i = 0; i < NUM_BYTES; i = i + 1) begin
        //    if(be[i]) mem[waddr][i] <= wdata[i*BYTE_WIDTH +: BYTE_WIDTH];
        //end
        if(be[0]) mem[waddr][0] <= wdata[7:0];
        if(be[1]) mem[waddr][1] <= wdata[15:8];
        if(be[2]) mem[waddr][2] <= wdata[23:16];
        if(be[3]) mem[waddr][3] <= wdata[31:24];
    end
    q <= mem[raddr];
end
endmodule
