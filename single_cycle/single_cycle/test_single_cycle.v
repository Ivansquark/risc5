`timescale 1ns/100ps

module test_single_cycle();

reg clk;

single_cycle processor0(.clk(clk));

initial begin
    $dumpvars;
    $display("test started");
    #10;
    $finish();
end

endmodule
