module led(
    input we,
    input [7:0]led_in,
    output [7:0]led_out
);
assign led_out = (we) ? led_in : led_out;

endmodule
