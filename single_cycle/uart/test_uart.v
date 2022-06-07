`timescale 1ns/100ps

module test_uart();

reg we;
reg clk;
reg [2:0]reg_num;
reg [31:0]wd;
reg rx;

uart uart0(.we(we), .clk(clk), .reg_num(reg_num), .rx(rx), .wd(wd));

initial begin
    $dumpvars;
    $display("test started");
    #100; $finish();
end

initial begin
    we = 1;
    clk = 0;
    reg_num = 3;
    wd = 32'h0000007F;
    rx = 1;
    #2;
    reg_num = 0;
    wd = 1;
    //cahnge brrr
    //#2; reg_num = 2; wd = 0;
    #4;
    we = 0;
// receive test
   rx = 0;
   #4; rx = 1;
   #4; rx = 1;
   #4; rx = 0;

end

always begin
    #1; clk = ~clk;
end

endmodule
