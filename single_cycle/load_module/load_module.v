//! * module thats allow to load from memory single byte and half byte to register
`include "../rv_defs.v"
module load_module(
    input [2:0] load_enable,
    input [1:0] low_address, // check what number of byte is wanted to load (low two bits of memory address)
    input [31:0] in,
    output reg [31:0] out
);

always @* begin
    case(load_enable)
        `LOAD_B: begin
            case(low_address)
                2'b00: out = {{24{in[7]}}, in[7:0]};
                2'b01: out = {{24{in[15]}}, in[15:8]};
                2'b10: out = {{24{in[23]}}, in[23:16]};
                2'b11: out = {{24{in[31]}}, in[31:24]};
            endcase
        end
        
        `LOAD_HW: begin
            case(low_address)
                2'b00: out = {{16{in[15]}}, in[15:0]};
               // begin
               //     out[15:0] = in[15:0];
               //     if(in[15])  out[31:16] = 1;
               //     else        out[31:16] = 0;
               // end
                2'b01: out = {{16{in[23]}}, in[23:8]};
                2'b10: out = {{16{in[31]}},in[31:16]};
                default: out = 32'bx;
            endcase
        end
        
        `LOAD_W: out = in;
        
        `LOAD_BU: begin
            case(low_address)
                2'b00: out = {{24{1'b0}}, in[7:0]};
                2'b01: out = {{24{1'b0}}, in[15:8]};
                2'b10: out = {{24{1'b0}}, in[23:16]};
                2'b11: out = {{24{1'b0}}, in[31:24]};
            endcase
        end
        
        `LOAD_HWU: begin
            case(low_address)
                2'b00: out = {{16{1'b0}}, in[15:0]};
                2'b01: out = {{16{1'b0}}, in[23:8]};
                2'b10: out = {{16{1'b0}}, in[31:16]};
                default: out = 32'bx;
            endcase
        end

    endcase
end

endmodule
