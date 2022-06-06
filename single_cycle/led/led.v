module led(
    input we,
    input [7:0]led_in,
    output reg [7:0]led_out
);

always @* begin
    if(we) led_out = led_in[7:0];
end

endmodule
