`timescale 1ns/100ps

module test_load_module();

reg [31:0]in;
reg [2:0] load;
reg [1:0] low_address;

load_module load1 (.load_enable(load), .low_address(low_address), .in(in));

initial begin
    $dumpvars;
    $display("start");
    #20 $finish();
end

initial begin
    in = 32'hf2f4f6f8;
    #0;

    low_address = 0;
    load = 0;
    #1;
    low_address = 1;
    load = 0;
    #1;
    low_address = 2;
    load = 0;
    #1;
    low_address = 3;
    load = 0;

    #2;low_address = 0;
    load = 1;
    #1;
    low_address = 1;
    load = 1;
    #1;
    low_address = 2;
    load = 1;
    #1;
    low_address = 3;
    load = 1;
    #2;
    
    
    low_address = 0;
    load = 3;
    #1;
    low_address = 1;
    load = 3;
    #1;
    low_address = 2;
    load = 3;
    #1;
    low_address = 3;
    load = 3;
    #2;

    low_address = 0;
    load = 4;
    #1;
    low_address = 1;
    load = 4;
    #1;
    low_address = 2;
    load = 4;
    #1;
    low_address = 3;
    load = 4;
    #2;

end

endmodule
