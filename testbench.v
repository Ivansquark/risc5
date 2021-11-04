'timescale 1 ns / 100 ps

module testbench();

reg clk = 1`b0;
always begin
	#1 clk <= ~clk;
end

wire clk1;

rv_alu rv_alu(clk(clk), clk1(clk1));



endmodule 