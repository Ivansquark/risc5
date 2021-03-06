module shift_reg #(parameter N = 8) (
    input clk,
    input reset,
    input [N-1:0]par_in,
    input ser_in,
    input load,
    output reg [N-1:0]par_out,
    output reg ser_out
);
always @(posedge clk, posedge reset) begin
    if(reset) par_out <= 0;
    else if(load) par_out <= par_in;
    else par_out <= {ser_in, par_out[N-1:1]};
end
assign ser_out = par_out[0];

endmodule
