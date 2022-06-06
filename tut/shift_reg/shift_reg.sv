module shift_reg(
    input clk;
    input reg [31:0]ctrl_reg,
    input reg [31:0]stat_reg,
    input reg [8:0]data_out,
    input reg [8:0]data_in,
    input reg [31:0]brr,
    output out
);

reg [8:0]shift,

always @(posedge clk) begin
    if(stat_reg[0] == 1) begin
        data_in <= shift;
        stat_reg[0] = 0;
    end
    else if(ctrl_reg[0] == 1) begin
        shift <= data_out;
        stat_reg[1] = 0;
        ctrl_reg[0] = 0;
        stat_reg[1] = 1;
        i = 0;
    end
    //transmit state machine
    else if(stat_reg[1] == 1) begin
        //TODO: 1 start bit then 8 shifts to right then 2 stop bits
        case (i)
            0:  begin 
                i = i + 1;                
                out = 0;
            end
            1: begin
                i = i + 1;
                out = shift[0];
                shift >> 1;
            end

    end
    //receive state machine
    else if(stat_reg[1] == 0) begin

    end
end

endmodule
