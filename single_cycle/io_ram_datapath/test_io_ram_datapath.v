`timescale 1ns/100ps

module test_io_ram_datapath();

reg clk=0;
reg [31:0]address=0;
reg [31:0]wd=0;
reg we=0;
reg [1:0]mem_ctrl=0;
reg rx=0;

io_ram_datapath path0(.clk(clk), .address(address), .wd(wd), .we(we), .mem_ctrl(mem_ctrl), .rx(rx));

initial begin
    $dumpvars;
    $display("test started");
    #20; $finish();
end

initial begin
    #1 we=1; 
    address = 32'h00400000;
    wd = 32'h00000001;
end

always begin
    #1; clk = ~clk;
end

endmodule
