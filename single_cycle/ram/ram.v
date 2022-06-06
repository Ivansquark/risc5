`include "../rv_defs.v"

module ram #(
    parameter N = 4
) 
(
    input clk,
    input we,
    input [1:0]mem_ctrl,
    input   [31:0]address, 
    input   [31:0]data_in,
    output  reg [31:0]data_out
);

// 1024*32 bits = 1024*4 bytes = 4 Kb 
reg [31:0]mem[2**N-1:0];

integer i;
initial begin
    for(i=0; i<2**N; i=i+1)
        mem[i] = 0;
end

// memory reads addresses aligned on 4
wire [29:0]word_addr = address[31:2];

always @(posedge clk) begin
   if (we) begin
       case(mem_ctrl)
           `STORE_B: begin 
               case(address[1:0]) 
                   2'b00: mem[word_addr] <= {mem[word_addr][31:8], data_in[7:0]};
                   2'b01: mem[word_addr] <= {mem[word_addr][31:16], data_in[7:0], mem[word_addr][7:0]};
                   2'b10: mem[word_addr] <= {mem[word_addr][31:24], data_in[7:0], mem[word_addr][15:0]};
                   2'b11: mem[word_addr] <= {data_in[7:0], mem[word_addr][23:0]};
               endcase                
           end
           `STORE_HW: begin
               case(address[1:0]) 
                   2'b00: mem[word_addr] <= {mem[word_addr][31:16], data_in[15:0]};
                   2'b01: mem[word_addr] <= {mem[word_addr][31:24], data_in[15:0], mem[word_addr][7:0]};
                   2'b10: mem[word_addr] <= {data_in[15:0], mem[word_addr][15:0]};
                   2'b11: mem[word_addr] <= 32'bx; //illegal instruction
               endcase                
           end
           `STORE_W: mem[word_addr] <= data_in;
       endcase
   end
   else data_out <= mem[address];
end

endmodule
