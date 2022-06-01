`timescale 1ns/100ps

module test_pc_plus4_adder();

reg [31:0]pc_next = 0;

pc_plus4_adder add1(.pc_next(pc_next));

initial begin
    $dumpvars;
    $display("start");
    #10;
    $finish();
end



endmodule
