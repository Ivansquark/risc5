`timescale 1ns/100ps

module test_fifo();

logic       clk;
logic [7:0] in;
logic       push;
logic       pop;

fifo dut(.clk(clk), .in(in), .push(push), .pop(pop));

initial begin
    $dumpvars;
    $display("test started");
    #40 $finish();
end

initial begin
    clk = 0; in = 0; push = 0; pop = 0;
    #2 in = 1; push = 1; pop = 0;
    #2 in = 2; push = 1; pop = 0;
    #2 in = 3; push = 1; pop = 0;
    #2 in = 4; push = 1; pop = 0;
    #4 push = 0; pop = 1;
    #2 push = 0; pop = 1;
    #2 in = 5; push = 1; pop = 0;
    #2 in = 6; push = 1; pop = 0;
    #2 push = 0; pop = 1;
    #2 push = 0; pop = 1;
    #2 push = 0; pop = 1;
    #2 push = 0; pop = 1;
    #2 in = 7; push = 1; pop = 0;
    #2 in = 8; push = 1; pop = 0;
    #2 in = 9; push = 1; pop = 1;
    #2 push = 0; pop = 1;
    #2 push = 0; pop = 1;


   // #2 in = 8; push = 1; pop = 0;
   // #2 in = 9; push = 1; pop = 1;
   // #2 push = 0; pop =1; 
end

always begin
    #1 clk = ~clk;
end

endmodule
