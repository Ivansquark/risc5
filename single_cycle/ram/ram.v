`include "../rv_defs.v"

module ram #(
    parameter N = 7
) 
(
    input clk,
    input   [3:0]mem_wmask,
    input   [31:0]address, 
    input   [31:0]data_in,
    output  reg [31:0]data_out
);

// 1024*32 bits = 1024*4 bytes = 4 Kb 
reg [31:0]mem[0 : 2**N - 1];

//memory reads addresses aligned on 4
wire [29:0]word_addr = address[31:2];
wire wr_en;
assign wr_en = (|mem_wmask);
always @(posedge clk) begin
    if(wr_en) begin
        if(mem_wmask[0]) mem[word_addr][ 7:0 ] <= data_in[ 7:0 ];
        if(mem_wmask[1]) mem[word_addr][15:8 ] <= data_in[15:8 ];
        if(mem_wmask[2]) mem[word_addr][23:16] <= data_in[23:16];
        if(mem_wmask[3]) mem[word_addr][31:24] <= data_in[31:24];
    end;
    data_out <= mem[word_addr];
end

endmodule
