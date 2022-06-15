`timescale 1ns/100ps

module test_sv_ram();

reg        clk;
reg        we;
reg  [3:0] be;
reg [31:0] address;
reg [31:0] address_r;
reg [31:0] in;

ram dut(.clk(clk), .we(we), .be(be), .waddr(address), .raddr(address_r), .wdata(in));

initial begin
    $dumpvars;
    $display("start");
    #32
    $finish();
end

initial begin
    clk = 0;
    be = 4'b0000;
    we = 1;
    address = 0;
    in = 32'h12345678;
    #2 address = 1; be = 4'b0001;
    #2 address = 2; be = 4'b0001;
    #2 address = 4; be = 4'b0011;
    #2 address = 5; be = 4'b0110;
    
    #2 address = 12; be = 4'b1111;
    #2 we = 0; address_r = 0;
    #2 address_r = 4;
    #2 address_r = 8;
    #2 address_r = 12;
end

always begin
    #1;
    clk=~clk;
end

endmodule
