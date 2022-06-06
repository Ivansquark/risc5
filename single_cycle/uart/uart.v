`include "../rv_defs.v"
module uart(
    input we,
    input clk,
    input [2:0]reg_num,
    input [31:0]wd,
    input rx,
    output reg [31:0]rd,
    output tx
);

reg [31:0] uart_regs[4:0];
reg [3:0]tx_counter; // count till 8
reg [31:0]baud_counter;
reg [7:0]shift_receive = 0;
reg [7:0]shift_transmit = 0;
reg current_bit;
reg Tx;
reg is_need_start_tx;
reg is_tx_started;
integer i;
initial begin
    for(i = 0; i < 5; i = i + 1) uart_regs[i] = 0;
    Tx = 1;
    tx_counter = 0;
    baud_counter = 0;
    is_tx_started = 0;
    is_need_start_tx = 0;
end
assign tx = Tx;

wire rx_not_empty = uart_regs[`UART_MUX_STAT][31];


always @(posedge clk) begin
    case(reg_num)
        `UART_MUX_CTRL: begin
            if(we) uart_regs[`UART_MUX_CTRL] <= wd;
            else rd <= uart_regs[`UART_MUX_CTRL];
        end
        `UART_MUX_STAT: begin
            if(we) uart_regs[`UART_MUX_STAT] <= wd;
            else rd <= uart_regs[`UART_MUX_STAT];
        end
        `UART_MUX_BAUD: begin
            if(we) uart_regs[`UART_MUX_BAUD] <= wd;
            else rd <= uart_regs[`UART_MUX_BAUD];
        end
        `UART_MUX_TDR: begin
            if(we) uart_regs[`UART_MUX_TDR] <= wd;
            else rd <= uart_regs[`UART_MUX_TDR];
        end
        `UART_MUX_RDR: begin
            if(we) uart_regs[`UART_MUX_RDR] <= wd;
            else rd <= uart_regs[`UART_MUX_RDR];
        end
    endcase
    //transmit
    if(is_need_start_tx) begin
        uart_regs[`UART_MUX_CTRL][0] <= 0;
        shift_transmit = uart_regs[`UART_MUX_TDR][7:0];
        uart_regs[`UART_MUX_STAT][1] <= 1;
        baud_counter = 0;
    end
    if(is_tx_started) begin
        case(tx_counter)
            //send start bit
            0: begin
                Tx = 0;
                if(baud_counter == uart_regs[`UART_MUX_BAUD]) begin
                    tx_counter <= tx_counter + 1;
                    baud_counter <= 0;
                    current_bit <= shift_transmit[0];
                end
                else baud_counter <= baud_counter + 1;
            end
            1: begin
                Tx <= current_bit; //send first least significant bit
                if(baud_counter == uart_regs[`UART_MUX_BAUD]) begin
                    tx_counter <= tx_counter + 1;
                    baud_counter <= 0;
                    current_bit <= shift_transmit[1];
                end
                else baud_counter <= baud_counter + 1;
            end
            2: begin
                Tx <= current_bit; //send second least significant bit
                if(baud_counter == uart_regs[`UART_MUX_BAUD]) begin
                    tx_counter <= tx_counter + 1;
                    baud_counter <= 0;
                    current_bit <= shift_transmit[2];
                end
                else baud_counter <= baud_counter + 1;
            end
            3: begin
                Tx <= current_bit; //send third least significant bit
                if(baud_counter == uart_regs[`UART_MUX_BAUD]) begin
                    tx_counter <= tx_counter + 1;
                    baud_counter <= 0;
                    current_bit <= shift_transmit[3];
                end
                else baud_counter <= baud_counter + 1;
            end
            4: begin
                Tx <= current_bit; //send fourth least significant bit
                if(baud_counter == uart_regs[`UART_MUX_BAUD]) begin
                    tx_counter <= tx_counter + 1;
                    baud_counter <= 0;
                    current_bit <= shift_transmit[4];
                end
                else baud_counter <= baud_counter + 1;
            end
            5: begin
                Tx <= current_bit; //send fifth least significant bit
                if(baud_counter == uart_regs[`UART_MUX_BAUD]) begin
                    tx_counter <= tx_counter + 1;
                    baud_counter <= 0;
                    current_bit <= shift_transmit[5];
                end
                else baud_counter <= baud_counter + 1;
            end
            6: begin
                Tx <= current_bit; //send sixth least significant bit
                if(baud_counter == uart_regs[`UART_MUX_BAUD]) begin
                    tx_counter <= tx_counter + 1;
                    baud_counter <= 0;
                    current_bit <= shift_transmit[6];
                end
                else baud_counter <= baud_counter + 1;
            end
            7: begin
                Tx <= current_bit; //send seventh least significant bit
                if(baud_counter == uart_regs[`UART_MUX_BAUD]) begin
                    tx_counter <= tx_counter + 1;
                    baud_counter <= 0;
                    current_bit <= shift_transmit[7];
                end
                else baud_counter <= baud_counter + 1;
            end
            8: begin
                Tx <= current_bit; //send stop bit
                if(baud_counter == uart_regs[`UART_MUX_BAUD]) begin
                    tx_counter <= tx_counter + 1;
                    baud_counter <= 0;
                    current_bit <= 1;   
                end
                else baud_counter <= baud_counter + 1;
            end
            9: begin
                Tx <= current_bit; //send stop bit
                if(baud_counter == uart_regs[`UART_MUX_BAUD]) begin
                    tx_counter <= 0;
                    baud_counter <= 0;
                    current_bit <= 1;
                    uart_regs[`UART_MUX_STAT][1] <= 0; //stop sending   is_tx_started = 0;
                    is_tx_started <= 0;
                end
                else baud_counter <= baud_counter + 1;
            end
        endcase
    end
    else begin //tx not started
        is_need_start_tx = uart_regs[`UART_MUX_CTRL][0];
        is_tx_started   <= uart_regs[`UART_MUX_STAT][1];
    end
end

endmodule
