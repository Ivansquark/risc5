// parametric fifo
module fifo#(
    parameter WIDTH = 8, 
    parameter BASE  = 2,
    parameter SIZE  = 2**BASE
)(
    input                       clk,
    input        [WIDTH - 1:0]  in,
    input                       push,
    input                       pop,
    output logic                is_empty,
    output logic                is_full,
    output logic [WIDTH - 1:0]  out
);

logic [WIDTH - 1:0] mem [0:SIZE];
logic [BASE] write_ptr;
logic [BASE] read_ptr;

initial begin
    write_ptr = 0; read_ptr = 0;
    is_empty = 1; is_full = 0;
end

wire [7:0]temp0;
wire [7:0]temp1;
wire [7:0]temp2;
wire [7:0]temp3;
assign temp0 = mem[0];
assign temp1 = mem[1];
assign temp2 = mem[2];
assign temp3 = mem[3];

always_ff @(posedge clk) begin
    if(push) begin
        if(!is_full) begin
            mem[write_ptr] <= in;
            is_empty <= 0;
            if(write_ptr < SIZE) write_ptr <= write_ptr + 1;
            else write_ptr <= 0;
        end        
    end
end

always_comb begin
    if(push) begin
        if(!is_empty) begin
            if (write_ptr == read_ptr) is_full = 1;
            else is_full = 0;
        end
    end
end

always_ff @(posedge clk) begin
    if(pop) begin
        if(!is_empty) begin
            out <= mem[read_ptr];
            is_full <= 0;
            if(read_ptr < SIZE) read_ptr <= read_ptr + 1;
            else read_ptr <= 0;
        end
    end    
end

always_comb begin
    if(pop) begin
        if(!is_full) begin
            if (read_ptr == write_ptr) is_empty = 1;
            else is_empty = 0;
        end
    end
end

endmodule
