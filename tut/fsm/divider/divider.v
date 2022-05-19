// parametric divider (max 4)
module divider (
    input [1:0]N,
    input clk,
    output out
);
reg [2:0]pres_state = 0;
reg out_clk = 1;

always @(posedge clk or negedge clk)
begin
    case (N)
        2'b00: out_clk = out_clk ^ 1; 
        2'b01: // divide on 2
            if (pres_state == 1)
                begin
                    out_clk <= out_clk ^ 1;
                    pres_state <= 3'b000;
                end
            else 
                begin                 
                    pres_state <= pres_state + 1;
                end
        2'b10: // divide on 3        
           if (pres_state == 2)
                begin
                    out_clk <= out_clk ^ 1;
                    pres_state <= 3'b000;
                end
            else 
                begin                 
                    pres_state <= pres_state + 1;
                end        
        2'b11: // divide on 4        
           if (pres_state == 3)
                begin
                    out_clk <= out_clk ^ 1;
                    pres_state <= 3'b000;
                end
            else 
                begin                 
                    pres_state <= pres_state + 1;
                end
        default: out_clk <= out_clk ^ 1;
    endcase    
end
assign out = out_clk;
endmodule
