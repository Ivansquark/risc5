`timescale 1ns/100ps

module test_pc_target_add();

reg [31:0]pc_next = 32'h00000000;
reg [31:0]imm_ext = 32'hffffffff;

pc_target_add add1(.pc_next(pc_next), .imm_ext(imm_ext));

initial begin
    $dumpvars;
    $display("start");
    #10;
    $finish();
end

endmodule
