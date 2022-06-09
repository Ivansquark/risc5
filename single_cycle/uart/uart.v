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

initial begin
    for(i = 0; i < 5; i = i + 1)
        uart_regs[i] = 0;
end

// ---------    clock divider   ------------------ 
reg brr_clk = 0;
reg brr_clk_p = 0;
reg brr_clk_n = 0;
wire [31:0] baud = uart_regs[`UART_MUX_BAUD];
reg [31:0]baud_counter_clk = 0;

reg stat_reg_rx_not_empty = 0;
reg stat_reg_tx_is_started = 0;
reg ctrl_reg_tx_need_start = 0;
reg [7:0]rdr_data = 0;

always @(posedge clk) begin
   // check ctrl/stat registers
    uart_regs[`UART_MUX_STAT][31]   <=     stat_reg_rx_not_empty ;
    uart_regs[`UART_MUX_STAT][0]    <=     stat_reg_tx_is_started;
    uart_regs[`UART_MUX_CTRL][0]    <=     ctrl_reg_tx_need_start;
    uart_regs[`UART_MUX_RDR][7:0]   <=     rdr_data;       
    // read/write internal UART registers
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
                uart_regs[`UART_MUX_STAT][31] <= 0; // clear rx_not_empty
            end
        end
    endcase
    

    //clk divider on posedge
    if(baud == 32'h00000000) begin 
        brr_clk_p <= ~brr_clk_p;
    end
    else begin
        if(baud_counter_clk == uart_regs[`UART_MUX_BAUD]) begin
            brr_clk_p <= ~brr_clk_p;
            baud_counter_clk <= 0;
        end
        else begin
            baud_counter_clk <= baud_counter_clk + 1;
        end
        if(baud % 2 != 0) begin
            if(baud_counter_clk == uart_regs[`UART_MUX_BAUD]/2)
                brr_clk_p <= ~brr_clk_p;
        end
    end
end
always @(negedge clk) begin
    if(baud == 32'h00000000) begin 
        brr_clk_n <= ~brr_clk_n;
    end
    else begin
        if(baud % 2 == 0) begin
            if(baud_counter_clk == uart_regs[`UART_MUX_BAUD]/2)
                brr_clk_n <= ~brr_clk_p;
        end
    end
end

always @* begin
//    if(baud == 32'h00000000)
    brr_clk = ~(brr_clk_p ^ brr_clk_n);
end

// --------------   Receive (by shift register) -----------------------
wire rx_not_empty = uart_regs[`UART_MUX_STAT][31];
reg [3:0]rx_counter = 0;
wire [8:0]rx_data;      //parallel outputs of shift register
reg is_rx_started = 0;

// shift register with new clk
shift_reg shift_reg_rx(.clk(brr_clk), .ser_in(rx), .par_out(rx_data));
// rx by shift register (with new clk)
always @(posedge brr_clk) begin
    if(is_rx_started) begin
        if(rx_counter == 0) begin
            // received start bit in shift register
            rx_counter <= rx_counter + 1;
        end
        else begin
            if(rx_counter == 8) begin
                //receive full byte in shift reg
                rdr_data <= rx_data[8:1];
                rx_counter <= 0;
                is_rx_started <= 0;
                stat_reg_rx_not_empty <= 1;
            end
            else begin
                // received start bit in shift register
                rx_counter <= rx_counter + 1;
            end
        end
    end
    else begin
        if(!rx_not_empty) begin
            if(rx == 0) begin   // start bit
                is_rx_started <= 1;
            end
        end
    end
end

//transmit by FSM (finite state machine) very many of code

reg [3:0]tx_counter; // count till 8
reg [31:0]baud_counter_tx;
reg [7:0]shift_transmit = 0;
reg [8:0]tx_data = 0;
reg load = 0;
reg is_need_start_tx = 0;
reg is_tx_started = 0;
integer i;
// shift register with new clk
shift_reg shift_reg_tx(.clk(brr_clk), 
    .par_in(tx_data[8:0]),
    .ser_in(1'b1),
    .load(load),
    .ser_out(tx));

initial begin
    tx_counter = 0;
    is_tx_started = 0;
    is_need_start_tx = 0;
end

always @(posedge brr_clk) begin
    if(is_need_start_tx) begin
        tx_data <= {uart_regs[`UART_MUX_TDR][7:0], 1'b0};
        load <= 1;
        ctrl_reg_tx_need_start <= 0;
        stat_reg_tx_is_started <= 1;//start sending 
    end
    //start transmit
    if(stat_reg_tx_is_started) begin
        if(tx_counter == 0) begin
            tx_counter <= tx_counter + 1;
            load <= 0;
        end
        else if(tx_counter == 1) begin
                load <= 0;
                tx_counter <= tx_counter + 1;
        end
        else if(tx_counter == 9) begin
                    tx_counter <= 0;
                    is_tx_started <= 0;
                    stat_reg_tx_is_started <= 0;//stop sending   is_tx_started = 0;

        end
        else begin
            tx_counter <= tx_counter + 1;
            load <= 0;
        end
    end
    else begin //tx not started
        is_need_start_tx <= uart_regs[`UART_MUX_CTRL][0];
    end
end

endmodule
