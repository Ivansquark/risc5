`timescale 1ns/100ps

module test_uart();

reg we;
reg clk;
reg [2:0]reg_num;
reg [31:0]wd;

uart uart0(.we(we), .clk(clk), .reg_num(reg_num), .wd(wd));

initial begin
    $dumpvars;
    $display("test started");
    #50; $finish();
end

initial begin
    we = 1;
    clk = 0;
    reg_num = 3;
    wd = 32'h00000007F;
    #2;
    reg_num = 0;
    wd = 1;
    #2;
    we = 0;
end

always begin
    #1; clk = ~clk;
end

endmodule
