`timescale 1ns/100ps

module test_core();

reg clk=0;
reg reset = 1;
reg [31:0]instr;
reg [31:0]ram_data = 0;
core core0(.clk(clk), .reset(reset), .instr(instr), .ram_read_data(ram_data));

initial begin
    $dumpvars;
    $display("test started");
    #20;
    $finish();
end

initial begin
    #1;
    instr = 32'h00C00193;
    #2;
    instr = 32'h40000033;
    #2;
    instr = 32'h00000000;
    #2;
    instr = 32'h00000000;
    #2;
    instr = 32'h00000000;
    #1;
    instr = 32'h00000063;
    #2;
    instr = 32'hfeb018e3;
    #2;
    instr = 32'hFF718393;
    #2;
    instr = 32'h0023E233;
    #2;
    instr = 32'h0041F2B3;
    #2;
    instr = 32'h004282B3;

end

always begin
    #1;
    clk = ~clk;
end

endmodule
