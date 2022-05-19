module divide_by3FSM(input logic clk,
    input logic reset,
    output logic y
);

// statetype is 2bit logic with 3 states
typedef enum logic [1:0] {S0, S1, S2} statetype; // coding by default
//typedef enum logic [1:0] {S0 = 3b'001, S1 = 3b'010, S2 = 3b'100} statetype;

statetype currstate, nextstate;
// states register
always_ff @(posedge clk, posedge reset) // async reset
    if (reset) currstate <= S0;
    else currstate <= nextstate;
// next state logic (input logic)
always_comb
    case (currstate)
        S0: nextstate = S1;
        S1: nextstate = S2;
        S2: nextstate = S0;
        default: nextstate = S0;
    endcase
// output logic
assign y = (currstate == S0);

endmodule
