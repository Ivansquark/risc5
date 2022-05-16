module fsm (
    input   a;
    input   b;
    output  x;
)

reg states [3:0];
wire next_state;

always @*
begin
    case states
        0: next_state <= 1;
        1: next_state <= 2;
        2: next_state <= 3;
        3: next_state <= 4;
    endcase
    states <= next_state | (a & b);

end

endmodule;
