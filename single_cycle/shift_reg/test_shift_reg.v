`timescale 1ns/100ps

module test_shift_reg();

reg clk;
reg [7:0]par_in;
reg ser_in;
reg load;

shift_reg shift_reg0(.clk(clk), .par_in(par_in), .ser_in(ser_in), .load(load));

initial begin
    $dumpvars;
    $display("test started");
    #20;
    $finish();
end

initial begin
    clk = 0;
    ser_in = 1;
    load = 0;
    // test out
    //par_in = 8'h01;
    //#1; load = 0;
    // test in
    #1 ser_in = 0; 
    #1 ser_in = 1;
    #2 ser_in = 0;
end

always begin
    #1; clk = ~clk;
end

endmodule
