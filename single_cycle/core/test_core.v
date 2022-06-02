`timescale 1ns/100ps

module test_core();

reg clk=0;
core core0(.clk(clk));

initial begin
    $dumpvars;
    $display("test started");
    #10;
    $finish();
end

endmodule
