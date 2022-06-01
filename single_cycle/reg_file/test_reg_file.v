`timescale 1ns/100ps

module test_reg_file();

reg clk;
reg [4:0]a3 = 0;
reg [4:0]a1 = 0;
reg [4:0]a2 = 0;
reg we3 = 0;
reg [31:0]wd3 = 0;

reg_file reg_file1(.clk(clk), .a1(a1), .a2(a2), .a3(a3), .we3(we3), .wd3(wd3));

initial begin
    $dumpvars;
    $display("test started");
    #10;
    $finish();
end


initial begin
    clk=0;
    #1;
    we3 = 1;
    a3 = 1;
    wd3 = 32'h0000FFFF;
    #3;
    a3 = 2;
    wd3 = 32'hFFFF0000;
    a1 = 1;
    a2 = 2;
end

always begin
    #1;
    clk = ~clk;    
end

endmodule
