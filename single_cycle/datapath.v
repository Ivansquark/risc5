`include "pc_reg/pc_reg.v"
`include "reg_file/reg_file.v"
module datapath(
    input clk,
    input en,
    input reset,
    input reg_we,
    output rd1,
    output rd2
);

pc_reg pc_reg1();

endmodule
