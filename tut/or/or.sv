module orr (
    input logic [1:0] x,
    output logic y    
);

assign y = & x;

endmodule
