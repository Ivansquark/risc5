`timescale 1ns/100ps

module test_io_ram_decoder();

reg [31:0] address;

io_ram_decoder dec0(.address(address));

initial begin
    $dumpvars;
    $display("test started");
    #10; $finish();
end

endmodule
