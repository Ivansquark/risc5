module led(
    input we,
    output reg [7:0]led_out
);

reg [31:0]led_in;

always @* begin
    if(we) led_out = led_in[7:0];
end

endmodule
