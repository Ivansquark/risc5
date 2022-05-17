`timescale 1 ns / 100 ps

module test_moore ();

reg clk = 1'b0;
reg rst = 1'b1;
reg in  = 1'b0;

moore moore1(.clk(clk), .rst(rst), .in(in));

initial begin
    $dumpvars;
    $display("test moore started...");
    #20 $finish;
end

initial begin
    #0 rst = 0;
    #1 rst = 1;
    #5 in = 1'b1;
end
always begin
    #1 clk = ~clk;
end

endmodule
