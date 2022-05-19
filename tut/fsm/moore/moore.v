//! counter thats count up when input=1 and not count when input=0
module moore (
    input   clk,
    input   rst,
    input   in,
    output reg [1:0]out
);

reg [1:0] pres_state, next_state;
parameter s0 = 2'd0, s1 = 2'd1, s2 = 2'd2, s3 = 2'd3;   //sequential coding (states < 5)
//parameter s0 = 4'b0001, s1 = 4'b0010, s2 = 4'b0100, s3 = 4'b1000; // one-hot coding (states < 50)
//parameter s0 = 2'b00, s1 = 2'b01, s2 = 2'b11, s3 = 2'b10; // grey coding (states >= 50)
//
// FSM input combination logic (Next logic state)
always @(pres_state or in)
begin: fsm
    case (pres_state)
        s0: case(in)
                2'b0: next_state = s0;//blocked assingment (for combination logic)
                2'b1: next_state = s1;                    
            endcase
        s1: case(in)
                2'b0: next_state = s1;
                2'b1: next_state = s2;                    
            endcase
        s2: case(in)
                2'b0: next_state = s2;
                2'b1: next_state = s3;                    
            endcase
        s3: case(in)
                2'b0: next_state = s3;
                2'b1: next_state = s0;                    
            endcase
        default: next_state = s0;   // for all undescribed states    
        endcase
end //fsm

// FSM register (sequential logic)
always @(posedge clk or negedge rst) //asynchronous reset
begin: statereg
    if(!rst) 
        pres_state <= s0;    //blocked assingment (for combination logic)
    else
        pres_state <= next_state; //blocked assingment (for combination logic)
end // statereg


// FSM output logic
always @*
begin: outputs
    out = pres_state;
end //outputs

endmodule
