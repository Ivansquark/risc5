`timescale 1ns/100ps

module test_tworeg ();

logic d;
logic clk;

tworeg tworeg(.d(d), .clk(clk));

initial begin
    $dumpvars;
    $display("start");
    #20 $finish;
end 

initial begin
    #0 d = 0;
    #0 clk = 0;
    #10 d = 1;
end

always begin
    #1 clk = ~clk;
end

endmodule
