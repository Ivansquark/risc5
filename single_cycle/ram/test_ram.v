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
    #20
    $finish();
end

always begin
    #1;
    clk=~clk;
end

initial begin
    we = 1;
    in = 32'h12345678;
    #1
    address = 0;
    mem_ctrl = 0;
    #2
    address = 4;
    mem_ctrl = 1;
    #2
    address = 8;
    mem_ctrl = 2;
    
    #2
    address = 13;
    mem_ctrl = 0;
    
    #2
    address = 14;
    mem_ctrl = 1;

end

endmodule
