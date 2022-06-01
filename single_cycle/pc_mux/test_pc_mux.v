`timescale 1ns/100ps

module test_pc_mux();

reg [1:0]pc_src     = 2'h0;
reg [31:0]pc_plus4  = 32'h11111111;
reg [31:0]pc_target = 32'h22222222;
reg [31:0]pc_alu    = 32'h33333333;
reg [31:0]pc_prev   = 32'hFFFFFFFF;

pc_mux mux1(.pc_src(pc_src),  .pc_plus4(pc_plus4), .pc_target(pc_target), .pc_alu(pc_alu), .pc_prev(pc_prev));

initial begin
    $dumpvars;
    $display("start");
    #10;
    $finish();
end

initial begin
    pc_src = 0;
    #2;
    pc_src = 1;
    #2;
    pc_src = 2;
    #2;
    pc_src = 3;
end

endmodule
