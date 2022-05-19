`timescale 1ns/100ps

module test_or();

logic [1:0] x;

orr orr(.x(x));

initial begin
    $dumpvars;
    $display("start");
    #20 $finish();
end
initial begin
    #0 x = 2'b00;
    #2 x = 2'b01;
    #4 x = 2'b10;
    #6 x = 2'b11;
end

endmodule

