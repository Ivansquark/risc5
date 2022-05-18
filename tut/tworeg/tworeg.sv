module tworeg (
    input logic d,
    input logic clk,
    output logic q
);

logic temp_q;

always @(posedge clk) begin
    temp_q <= d;
    q <= temp_q;
end

endmodule
