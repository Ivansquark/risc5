module rom #(
parameter LENGTH = 1024, 
parameter WIDTH = 32) // - flash size in bits (= 4KB)
(
    input  [WIDTH - 1 : 0] address,    // Program Counter
    output [WIDTH - 1 : 0] instruction 
);

reg [WIDTH - 1 : 0] mem[LENGTH - 1 : 0]; //array of registers

assign instruction = mem[address[WIDTH-1 : 2]]; //address must be aligned on 4

initial begin
    $readmemh("program.hex", mem); //fill rom (for altera)
end

endmodule
