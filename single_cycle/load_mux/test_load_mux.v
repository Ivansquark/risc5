`timescale 1ns/100ps

module test_load_mux();

reg in=0;

load_mux mux0(.in(in));

initial begin
    $dumpvars;
    $display("test started");
    #10; $finish();
end

endmodule
