`timescale 1ns/100ps

module test_rom();

reg [31:0]address = 0;

rom rom1(.address(address));
//initial $readmemh("program.hex", rom1.mem);
initial begin
    $dumpvars;
    $display("test started");
    #10;
    $finish();
end

initial begin
    #2;
    address = 4;
    #2;
    address = 8;
    #2;
    address = 12;
end

endmodule
