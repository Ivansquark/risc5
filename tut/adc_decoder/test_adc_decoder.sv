`timescale 1ns/100ps

module test_adc_decoder();

reg [9:0] in;

adc_decoder decoder(.in(in));

initial begin
    $dumpvars;
    $display("test started");
    #10 $finish();
end

initial begin
    in = 0;
    #1
    in = 3;
end

endmodule
