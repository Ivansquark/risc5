`timescale 1ns/100ps

module test_shift_reg();

reg in;

shift_reg shift_reg0(.in(in));

initial begin
    $dumpvars;
    $display("test started");
    #10;
    $finish();
end

initial begin
    #1; in=1; #1; in=0;
end

endmodule
