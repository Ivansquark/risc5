`timescale 1ns/100ps

module test_alu_src_mux();

reg alu_src;
reg [31:0]rd2;
reg [31:0]imm_ext;

alu_src_mux mux1(.alu_src(alu_src), .rd2(rd2), .imm_ext(imm_ext));

initial begin
    $dumpvars;
    $display("start");
    #10;
    $finish();
end

initial begin
    alu_src = 0;
    rd2 = 32'hFFFFFFFF;
    imm_ext = 0;
    #2;
    alu_src = 1;
end

endmodule
