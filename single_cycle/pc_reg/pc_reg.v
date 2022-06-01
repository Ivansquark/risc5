module pc_reg(
    input clk,
    input en,                   // for debugger
    input reset,
    input [31:0]pc_prev,
    output reg [31:0]pc_next
);

always @(posedge clk, en, reset) begin
    if(en) pc_next <= pc_prev;
    if(!reset) pc_next <= 32'h00000000;
end

endmodule
