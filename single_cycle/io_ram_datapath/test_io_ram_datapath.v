`timescale 1ns/100ps

module test_io_ram_datapath();

reg clk=0;
reg [31:0]address=0;
reg [31:0]wd=0;
reg we=0;
reg [2:0]mem_ctrl=0;
reg rx=0;

io_ram_datapath path0(.clk(clk), .address(address), .wd(wd), .we(we), .mem_ctrl(mem_ctrl), .rx(rx));

initial begin
    $dumpvars;
    $display("test started");
    #60; $finish();
end

initial begin
    we=0; 
    address = 32'h00000000;
    wd = 32'h00000001;
    #2 we = 1; address = 32'h00000001; wd = 32'h00000001; mem_ctrl = 0;
    #2 we = 1; address = 32'h00000002; wd = 32'h00000001; mem_ctrl = 0;
    #2 we = 1; address = 32'h00000003; wd = 32'h00000001; mem_ctrl = 0;
    #2 we = 1; address = 32'h00000004; wd = 32'h12345678; mem_ctrl = 1;
    #2 we = 0; address = 32'h00000000; wd = 32'h00000001; mem_ctrl = 1;
    #2 we = 0; address = 32'h00000001; wd = 32'h00000001; mem_ctrl = 1;
    #2 we = 0; address = 32'h00000002; wd = 32'h00000001; mem_ctrl = 1;
    #2 we = 0; address = 32'h00000004; wd = 32'h00000001; mem_ctrl = 1;
    #2 we = 0; address = 32'h00000004; wd = 32'h00000001; mem_ctrl = 1;
    #2 we = 0; address = 32'h00000004; wd = 32'h00000001; mem_ctrl = 1;

    

    #2 we = 1; address = 32'h0040010C; wd = 32'h0000005F; mem_ctrl = 1;
    #2 we = 1; address = 32'h00400100; wd = 32'h00000001; mem_ctrl = 1;
    #2 we = 0; address = 32'h00400104;
end

always begin
    #1; clk = ~clk;
end

endmodule
