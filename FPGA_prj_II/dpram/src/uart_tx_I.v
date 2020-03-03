module uart_tx_I(
	clk,
	rst,
	baud_set,
	data_byte,
	send_en,
	rs232_Tx,
	tx_done,
	uart_state,
	bps_clk
);

parameter	start_bit = 1'd0,
				stop_bit = 1'd1;
input clk;
input rst;
input [2:0]baud_set;
input [7:0]data_byte;
input send_en;
output reg rs232_Tx;
output reg tx_done;
output uart_state;
output reg bps_clk;

reg [15:0]bps_DR;
reg [7:0]r_data_byte;
reg [15:0]div_cnt;
reg [3:0]bps_cnt;
reg uart_state;

always@(posedge clk or negedge rst)
	if(!rst)
		bps_DR <= 16'd5207;
	else begin
		case(baud_set)
			3'b000: bps_DR <= 16'd5207;
			3'b001: bps_DR <= 16'd2603;
			3'b010: bps_DR <= 16'd1301;
			3'b011: bps_DR <= 16'd867;
			3'b100: bps_DR <= 16'd433;
			default: bps_DR <= 16'd5207;
		endcase
	end

always@(posedge clk or negedge rst)
	if(!rst)
		r_data_byte <= 8'd0;
	else if(send_en)
		r_data_byte <= data_byte;
	else 
		r_data_byte <= r_data_byte;

always@(posedge clk or negedge rst)
	if(!rst)
		div_cnt <= 16'd0;
	else if(uart_state)begin
		if(div_cnt == bps_DR)
			div_cnt <= 16'd0;
		else 
			div_cnt <= div_cnt + 1'd1;
	end
	else 
		div_cnt <= 16'd0;
		
always@(posedge clk or negedge rst)
	if(!rst)
		bps_clk <= 1'd0;
	else if(div_cnt == 16'd1)
		bps_clk <= 1'd1;
	else
		bps_clk <= 1'd0;
		
always@(posedge clk or negedge rst)
	if(!rst)
		bps_cnt <= 4'd0;
	else if(bps_cnt==4'd11)
		bps_cnt <= 4'd0;
	else if(bps_clk)
		bps_cnt <= bps_cnt + 1'b1;
	else 
		bps_cnt <= bps_cnt;
		
always@(posedge clk or negedge rst)
	if(!rst)
		rs232_Tx <= stop_bit;
	else begin
		case(bps_cnt)
			4'd0: rs232_Tx <= stop_bit;
			4'd1: rs232_Tx <= start_bit;
			4'd2: rs232_Tx <= r_data_byte[0];
			4'd3: rs232_Tx <= r_data_byte[1];
			4'd4: rs232_Tx <= r_data_byte[2];
			4'd5: rs232_Tx <= r_data_byte[3];
			4'd6: rs232_Tx <= r_data_byte[4];
			4'd7: rs232_Tx <= r_data_byte[5];
			4'd8: rs232_Tx <= r_data_byte[6];
			4'd9: rs232_Tx <= r_data_byte[7];
			4'd10: rs232_Tx <= stop_bit;
			default rs232_Tx <= stop_bit;
		endcase 
	end

always@(posedge clk or negedge rst)
	if(!rst)
		tx_done <= 1'd0;
	else if(bps_cnt==4'd11)
		tx_done <= 1'd1;
	else 
		tx_done <= 1'd0;

always@(posedge clk or negedge rst)
	if(!rst)
		uart_state <= 1'd0;
	else if(send_en)
		uart_state <= 1'b1;
	else if(bps_cnt==4'd11)
		uart_state <= 1'b0;
	else 
		uart_state <= uart_state;
endmodule 
