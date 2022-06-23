module adc_decoder(
    input  [9:0]    in,
    output [1023:0] out
);

assign out  = 1'b1 << in;

endmodule
