// simple uart module with adjustable baud rate register
// Flags:
//      is_need_start_tx <= uart_regs[`UART_MUX_CTRL][0];
//      is_tx_started   <= uart_regs[`UART_MUX_STAT][1];
//      rx_not_empty = uart_regs[`UART_MUX_STAT][31]; cleared when read RDR

`include "../rv_defs.v"
`include "../shift_reg/shift_reg.v"
module uart(
    input we,
    input clk,
    input [2:0]reg_num,
    input [31:0]wd,
    input rx,
    output reg [31:0]rd,
    output tx
);

//registers renew
reg [31:0] uart_regs[4:0];

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
            if(!we) begin
                // automatic clear rx_not_empty status flag
                rd <= uart_regs[`UART_MUX_RDR];
                uart_regs[`UART_MUX_STAT][31] = 0; // clear rx_not_empty
            end
        end
    endcase
end

//transmit by FSM (finite state machine) very many of code
reg [3:0]tx_counter; // count till 8
reg [31:0]baud_counter_tx;
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
    baud_counter_tx = 0;
    is_tx_started = 0;
    is_need_start_tx = 0;
end
assign tx = Tx;

always @(posedge clk) begin
    if(is_need_start_tx) begin
        uart_regs[`UART_MUX_CTRL][0] <= 0;
        shift_transmit = uart_regs[`UART_MUX_TDR][7:0];
        uart_regs[`UART_MUX_STAT][1] <= 1;
        baud_counter_tx = 0;
    end
    if(is_tx_started) begin
        case(tx_counter)
            //send start bit
            0: begin
                Tx = 0;
                if(baud_counter_tx == uart_regs[`UART_MUX_BAUD]) begin
                    tx_counter <= tx_counter + 1;
                    baud_counter_tx <= 0;
                    current_bit <= shift_transmit[0];
                end
                else baud_counter_tx <= baud_counter_tx + 1;
            end
            1: begin
                Tx <= current_bit; //send first least significant bit
                if(baud_counter_tx == uart_regs[`UART_MUX_BAUD]) begin
                    tx_counter <= tx_counter + 1;
                    baud_counter_tx <= 0;
                    current_bit <= shift_transmit[1];
                end
                else baud_counter_tx <= baud_counter_tx + 1;
            end
            2: begin
                Tx <= current_bit; //send second least significant bit
                if(baud_counter_tx == uart_regs[`UART_MUX_BAUD]) begin
                    tx_counter <= tx_counter + 1;
                    baud_counter_tx <= 0;
                    current_bit <= shift_transmit[2];
                end
                else baud_counter_tx <= baud_counter_tx + 1;
            end
            3: begin
                Tx <= current_bit; //send third least significant bit
                if(baud_counter_tx == uart_regs[`UART_MUX_BAUD]) begin
                    tx_counter <= tx_counter + 1;
                    baud_counter_tx <= 0;
                    current_bit <= shift_transmit[3];
                end
                else baud_counter_tx <= baud_counter_tx + 1;
            end
            4: begin
                Tx <= current_bit; //send fourth least significant bit
                if(baud_counter_tx == uart_regs[`UART_MUX_BAUD]) begin
                    tx_counter <= tx_counter + 1;
                    baud_counter_tx <= 0;
                    current_bit <= shift_transmit[4];
                end
                else baud_counter_tx <= baud_counter_tx + 1;
            end
            5: begin
                Tx <= current_bit; //send fifth least significant bit
                if(baud_counter_tx == uart_regs[`UART_MUX_BAUD]) begin
                    tx_counter <= tx_counter + 1;
                    baud_counter_tx <= 0;
                    current_bit <= shift_transmit[5];
                end
                else baud_counter_tx <= baud_counter_tx + 1;
            end
            6: begin
                Tx <= current_bit; //send sixth least significant bit
                if(baud_counter_tx == uart_regs[`UART_MUX_BAUD]) begin
                    tx_counter <= tx_counter + 1;
                    baud_counter_tx <= 0;
                    current_bit <= shift_transmit[6];
                end
                else baud_counter_tx <= baud_counter_tx + 1;
            end
            7: begin
                Tx <= current_bit; //send seventh least significant bit
                if(baud_counter_tx == uart_regs[`UART_MUX_BAUD]) begin
                    tx_counter <= tx_counter + 1;
                    baud_counter_tx <= 0;
                    current_bit <= shift_transmit[7];
                end
                else baud_counter_tx <= baud_counter_tx + 1;
            end
            8: begin
                Tx <= current_bit; //send stop bit
                if(baud_counter_tx == uart_regs[`UART_MUX_BAUD]) begin
                    tx_counter <= tx_counter + 1;
                    baud_counter_tx <= 0;
                    current_bit <= 1;   
                end
                else baud_counter_tx <= baud_counter_tx + 1;
            end
            9: begin
                Tx <= current_bit; //send stop bit
                if(baud_counter_tx == uart_regs[`UART_MUX_BAUD]) begin
                    tx_counter <= 0;
                    baud_counter_tx <= 0;
                    current_bit <= 1;
                    uart_regs[`UART_MUX_STAT][1] <= 0; //stop sending   is_tx_started = 0;
                    is_tx_started <= 0;
                end
                else baud_counter_tx <= baud_counter_tx + 1;
            end
        endcase
    end
    else begin //tx not started
        is_need_start_tx <= uart_regs[`UART_MUX_CTRL][0];
        is_tx_started   <= uart_regs[`UART_MUX_STAT][1];
    end
end

// --------------   Receive (by shift register) -----------------------
wire rx_not_empty = uart_regs[`UART_MUX_STAT][31];
reg [3:0]rx_counter;
reg [31:0]baud_counter_clk;
wire [7:0]rx_data;
reg is_rx_started;
reg brr_clk = 0;
wire [31:0] baud = uart_regs[`UART_MUX_BAUD];

initial begin
    rx_counter = 0;
    is_rx_started = 0;
    baud_counter_clk = 0;
    brr_clk = 0;
end
// clk divider 
always @(posedge clk) begin
    if(baud == 32'h00000000) begin 
        brr_clk <= clk;
    end
    else begin
        if(baud_counter_clk == uart_regs[`UART_MUX_BAUD]) begin
            brr_clk <= ~brr_clk;
            baud_counter_clk <= 0;
        end
        else begin
            baud_counter_clk <= baud_counter_clk + 1;
        end
        if(baud % 2 != 0) begin
            if(baud_counter_clk == uart_regs[`UART_MUX_BAUD]/2)
                brr_clk <= ~brr_clk;
        end
    end
end
always @(negedge clk) begin
    if(baud == 32'h00000000) begin 
        brr_clk <= ~brr_clk;
    end
    else begin
        if(baud % 2 == 0) begin
            if(baud_counter_clk == uart_regs[`UART_MUX_BAUD]/2)
                brr_clk <= ~brr_clk;
        end
    end
end
// shift register with new clk
shift_reg shift_reg_rx(.clk(brr_clk), .ser_in(rx), .par_out(rx_data));
// rx by shift register (with new clk)
always @(posedge brr_clk) begin
    if(is_rx_started) begin
        if(rx_counter == 0) begin
            // received start bit in shift register
            rx_counter = rx_counter + 1;
        end
        else begin
            if(rx_counter == 8) begin
                //receive full byte in shift reg
                uart_regs[`UART_MUX_RDR][7:0] <= rx_data;
                rx_counter = 0;
                is_rx_started = 0;
                uart_regs[`UART_MUX_STAT][31] = 1; // set rx_not_empty
            end
            else begin
                // received start bit in shift register
                rx_counter = rx_counter + 1;
            end
        end
    end
    else begin
        if(!rx_not_empty) begin
            if(rx == 0) begin   // start bit
                is_rx_started = 1;
            end
        end
    end
end

endmodule
