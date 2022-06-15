`timescale 1ns/100ps

module test_ram();

    reg [31:0] in;
    reg [3:0] mem_wmask;
    reg we;
    reg [31:0]address;
    reg clk;

    ram dut(.clk(clk), .we(we), .mem_wmask(mem_wmask), .address(address), .data_in(in));

initial begin
    $dumpvars;
    $display("start");
    #32
    $finish();
end

initial begin
    clk = 0;
    mem_wmask = 4'b1111;
    we = 1;
    address = 0;
    in = 32'h12345678;
    #2
    address = 1;
    mem_wmask = 4'b0001;
    #2
    address = 2;
    mem_wmask = 4'b0001;
    #2
    address = 4;
    mem_wmask = 4'b0011;
    #2
    address = 5;
    mem_wmask = 4'b0110;
    
    #2
    address = 12;
    mem_wmask = 4'b1111;
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
