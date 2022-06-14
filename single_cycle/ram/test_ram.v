`timescale 1ns/100ps

module test_ram();

    reg [31:0] in;
    reg [1:0] mem_ctrl;
    reg we;
    reg [31:0]address;
    reg clk;

    ram dut(.clk(clk), .we(we), .mem_ctrl(mem_ctrl), .address(address), .data_in(in));

initial begin
    $dumpvars;
    $display("start");
    #32
    $finish();
end

initial begin
    clk = 0;
    mem_ctrl = 0;
    we = 1;
    address = 4;
    in = 32'h12345678;
    #2
    address = 5;
    mem_ctrl = 0;
    #2
    address = 6;
    mem_ctrl = 0;
    #2
    address = 4;
    mem_ctrl = 1;
    #2
    address = 5;
    mem_ctrl = 1;
    
    #2
    address = 12;
    mem_ctrl = 2;
    #2 we = 0;
    address = 0;
    #2 address = 4;
    #2 address = 8;
    #2 address = 12;
end

always begin
    #1;
    clk=~clk;
end

endmodule
