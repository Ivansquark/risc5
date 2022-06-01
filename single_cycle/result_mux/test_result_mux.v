`timescale 1ns/100ps

module test_result_mux();

reg [2:0] res_src = 0;
reg [31:0] alu_res = 32'hFFFF0000;
reg [31:0] mem = 32'h00001111;

result_mux mux1(.res_src(res_src), .alu_res(alu_res), .mem(mem));

initial begin
    $dumpvars;
    $display("test started");
    #10;
    $finish();
end

initial begin
    res_src = 0;
    #2;
    res_src = 1;
end

endmodule
