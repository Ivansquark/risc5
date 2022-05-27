module pc_reg(
    input clk,
    input [31:0]pc_prev,
    output [31:0]pc_next
);

always @(posedge clk) begin
    pc_next <= pc_prev;
end

endmodule
