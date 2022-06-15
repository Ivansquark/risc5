module shift_reg #(parameter N = 9) (
    input clk,
    input [N-1:0]par_in,
    input ser_in,
    input load,
    output reg [N-1:0]par_out,
    output ser_out
);

initial begin
    par_out = {{N{1'b1}}};
end

always @(posedge clk) begin
    if(load) par_out <= par_in;
    else par_out <= {ser_in, par_out[N-1:1]};
end
assign ser_out = par_out[0];

endmodule
