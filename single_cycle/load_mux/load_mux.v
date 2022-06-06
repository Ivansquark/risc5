module load_mux(
    input in,
    input [31:0] data_ram,
    input [31:0] data_uart,
    output [31:0] loaded_data
);

assign loaded_data = (loaded_data) ? data_uart : data_ram;

endmodule
