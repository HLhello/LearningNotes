module uart_rx(
	clk,
	rst,
	baud_set,
	rs232_rx,
	data_byte,
	rx_done
);

parameter err_value = 3'd2;

input clk;
input rst;
input [2:0]baud_set;
input rs232_rx;
output reg [7:0]data_byte;
output reg rx_done;

reg [15:0]bps_DR;
reg uart_state;
reg [15:0]div_cnt;
reg [7:0]bps_cnt;
reg [2:0]start_bit;
reg [2:0]r_data_byte[7:0];
reg [2:0]stop_bit;

reg rs232_rx_tmp1, rs232_rx_tmp2;
always@(posedge clk)
	rs232_rx_tmp1 <= rs232_rx;
always@(posedge clk)
	rs232_rx_tmp2 <= rs232_rx_tmp1;
	
reg rs232_rx_r1, rs232_rx_r2;
always@(posedge clk)
	rs232_rx_r1 <= rs232_rx_tmp2;
always@(posedge clk)
	rs232_rx_r2 <= rs232_rx_r1;

wire rs232_nedge;
assign rs232_nedge = (rs232_rx_r2 && !rs232_rx_r1);

wire bps_full;
assign bps_full = (bps_cnt==8'd159 && div_cnt==bps_DR);

wire start_err;
assign start_err = (bps_cnt==8'd12 && (start_bit>err_value));

wire bps_clr;
assign bps_clr = (bps_full || start_err);

always@(posedge clk or negedge rst)
	if(!rst)
		bps_DR <= 16'd324;
	else begin
		case(baud_set)
			3'b000: bps_DR <= 16'd324;
			3'b001: bps_DR <= 16'd162;
			3'b010: bps_DR <= 16'd80;
			3'b011: bps_DR <= 16'd53;
			3'b100: bps_DR <= 16'd26;
			default: bps_DR <= 16'd324;
		endcase
	end
	
always@(posedge clk or negedge rst)
	if(!rst)
		uart_state <= 1'd0;
	else if(rs232_nedge)
		uart_state <= 1'd1;
	else if(bps_clr)
		uart_state <= 1'd0;

always@(posedge clk or negedge rst)
	if(!rst)
		div_cnt <= 16'd0;
	else if(uart_state && div_cnt<bps_DR)
		div_cnt <= div_cnt + 1'd1;
	else if(uart_state && div_cnt==bps_DR)
		div_cnt <= 16'd0;

always@(posedge clk or negedge rst)
	if(!rst)
		bps_cnt <= 8'd0;
	else if(bps_clr)
		bps_cnt <= 8'd0;
	else if(div_cnt==bps_DR)
		bps_cnt <= bps_cnt + 1'd1;
		
always@(posedge clk or negedge rst)
	if(!rst)
		rx_done  <= 1'd0;
	else if(bps_full)
		rx_done <= 1'd1;
	else 
		rx_done <= 1'd0;

always@(posedge clk or negedge rst)
	if(!rst)
		begin
			start_bit <= 3'd0;
			r_data_byte[0] <= 3'd0;	
			r_data_byte[1] <= 3'd0;
			r_data_byte[2] <= 3'd0;
			r_data_byte[3] <= 3'd0;
			r_data_byte[4] <= 3'd0;
			r_data_byte[5] <= 3'd0;
			r_data_byte[6] <= 3'd0;
			r_data_byte[7] <= 3'd0;
			stop_bit <= 3'd0;
		end
	else 
		begin
			case(bps_cnt)
				0: 
					begin
						start_bit <= 3'd0;
						r_data_byte[0] <= 3'd0;	
						r_data_byte[1] <= 3'd0;
						r_data_byte[2] <= 3'd0;
						r_data_byte[3] <= 3'd0;
						r_data_byte[4] <= 3'd0;
						r_data_byte[5] <= 3'd0;
						r_data_byte[6] <= 3'd0;
						r_data_byte[7] <= 3'd0;
						stop_bit <= 3'd0;
					end
				6  ,7  ,8  ,9  ,10 ,11 : start_bit <= start_bit + rs232_rx_r2;
				22 ,23 ,24 ,25 ,26 ,27 : r_data_byte[0] <= r_data_byte[0] + rs232_rx_r2;
				38 ,39 ,40 ,41 ,42 ,43 : r_data_byte[1] <= r_data_byte[1] + rs232_rx_r2;
				54 ,55 ,56 ,57 ,58 ,59 : r_data_byte[2] <= r_data_byte[2] + rs232_rx_r2;
				70 ,71 ,72 ,73 ,74 ,75 : r_data_byte[3] <= r_data_byte[3] + rs232_rx_r2;
				86 ,87 ,88 ,89 ,90 ,91 : r_data_byte[4] <= r_data_byte[4] + rs232_rx_r2;
				102,103,104,105,106,107: r_data_byte[5] <= r_data_byte[5] + rs232_rx_r2;
				118,119,120,121,122,123: r_data_byte[6] <= r_data_byte[6] + rs232_rx_r2;
				134,135,136,137,138,139: r_data_byte[7] <= r_data_byte[7] + rs232_rx_r2;
				150,151,152,153,154,155: stop_bit <= stop_bit + 1'd1;
				default: 
					begin
						start_bit <= start_bit;
						r_data_byte[0] <= r_data_byte[0];	
						r_data_byte[1] <= r_data_byte[1];
						r_data_byte[2] <= r_data_byte[2];
						r_data_byte[3] <= r_data_byte[3];
						r_data_byte[4] <= r_data_byte[4];
						r_data_byte[5] <= r_data_byte[5];
						r_data_byte[6] <= r_data_byte[6];
						r_data_byte[7] <= r_data_byte[7];
						stop_bit <= stop_bit;
					end
			endcase
		end
	
always@(posedge clk or negedge rst)
	if(!rst)
		data_byte <= 8'b0000_0000;
	else if(bps_full) 
		begin 
			data_byte[0] <= r_data_byte[0][2];
			data_byte[1] <= r_data_byte[1][2];
			data_byte[2] <= r_data_byte[2][2];
			data_byte[3] <= r_data_byte[3][2];
			data_byte[4] <= r_data_byte[4][2];
			data_byte[5] <= r_data_byte[5][2];
			data_byte[6] <= r_data_byte[6][2];
			data_byte[7] <= r_data_byte[7][2];		
		end
		
endmodule 
