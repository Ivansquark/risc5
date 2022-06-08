`timescale 1ns/100ps

module test_led();

reg we=1;
reg [7:0]in;
wire [7:0]out;

led led0(
    .we(we), .led_in(in),
    .led_out(out));

initial begin
    $dumpvars;
    $display("test started");
    #10; $finish();
end

initial begin
    #1; in=1; 
    #1; in=2; 
    #1; in=4;
end

endmodule
