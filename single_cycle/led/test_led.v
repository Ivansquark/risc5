`timescale 1ns/100ps

module test_led();

reg [31:0]in;

led led0();

initial begin
    $dumpvars;
    $display("test started");
    #10; $finish();
end

initial begin
    in=0; 
    led0.led_in=in;
    #1; in=1; 
    led0.led_in=in;
    #1; in=2; 
    led0.led_in=in;
    #1; in=4;
    led0.led_in=in;
end

endmodule
