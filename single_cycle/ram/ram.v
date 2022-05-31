`define STORE_B     0
`define STORE_HW    1
`define STORE_W     2
// TODO: write byte half word and word by bit mask
// we 00: read, 01: 
module ram (
    #parameter N = 10;
) 
(
    input clk,
    input we,
    input [1:0]mem_ctrl,
    input   [31:0]address, 
    input   [31:0]data_in,
    output  [31:0]data_out,
);

// 1024*32 bits = 1024*4 bytes = 4 Kb 
reg [31:0]mem[2**N-1];

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
                    2'b11: mem[word_addr] <= {mem[word_addr][data_in[7:0], mem[word_addr][23:0]};
                endcase                
            end;
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
