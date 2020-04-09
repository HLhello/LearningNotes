module uart_byte_rx(
	clk,
	rst,
	baud_set,
	rs232_rx,
	rx_byte,
	rx_done
);

input clk;
input rst;
input [2:0]baud_set;
input rs232_rx;

output reg [7:0]rx_byte;
output reg rx_done;

reg [6:0]bps_cnt;
reg [1:0]data_tmp[7:0];
reg [1:0]start_bit;
reg [1:0]stop_bit;
wire byte_en;
wire bps_clk; 		

//过滤毛刺
reg rs232_rx0, rs232_rx1, rs232_rx2, rs232_rx3;
always@(posedge clk or negedge rst)
	if(!rst)
		begin
			rs232_rx0 <= 1'd0;
			rs232_rx1 <= 1'd0;
			rs232_rx2 <= 1'd0;
			rs232_rx3 <= 1'd0;
		end
	else 
		begin
			rs232_rx0 <= rs232_rx;
			rs232_rx1 <= rs232_rx0;
			rs232_rx2 <= rs232_rx1;
			rs232_rx3 <= rs232_rx2;
		end
// 检测下降沿
wire neg_rs232 = rs232_rx3 & rs232_rx2 & !rs232_rx1 & !rs232_rx0;

//采样数据

always@(posedge clk or negedge rst)
	if(!rst)
		bps_cnt <= 7'd0;
	else if(bps_clk)
		begin
			if(bps_cnt == 7'd89)
				bps_cnt <= 7'd0;
			else 
				bps_cnt <= bps_cnt + 1'd1;
		end
	else 
		bps_cnt <= bps_cnt;

always@(posedge clk or negedge rst)
	if(!rst)
		begin
			start_bit <= 2'd0;
			data_tmp[0] <= 2'd0;
			data_tmp[1] <= 2'd0;
			data_tmp[2] <= 2'd0;
			data_tmp[3] <= 2'd0;
			data_tmp[4] <= 2'd0;
			data_tmp[5] <= 2'd0;
			data_tmp[6] <= 2'd0;
			data_tmp[7] <= 2'd0;
			stop_bit <= 2'd0;
		end
	else if(bps_clk)
		begin
			case(bps_cnt)
				7'd0:begin
						start_bit <= 2'd0;
						data_tmp[0] <= 2'd0;
						data_tmp[1] <= 2'd0;
						data_tmp[2] <= 2'd0;
						data_tmp[3] <= 2'd0;
						data_tmp[4] <= 2'd0;
						data_tmp[5] <= 2'd0;
						data_tmp[6] <= 2'd0;
						data_tmp[7] <= 2'd0;
						stop_bit <= 2'd0;
					end
				7'd3 , 7'd4 , 7'd5 :start_bit <= start_bit + rs232_rx;
				7'd12, 7'd13, 7'd14:data_tmp[0] <= data_tmp[0] + rs232_rx;
				7'd21, 7'd22, 7'd23:data_tmp[1] <= data_tmp[1] + rs232_rx;
				7'd30, 7'd31, 7'd32:data_tmp[2] <= data_tmp[2] + rs232_rx;
				7'd39, 7'd40, 7'd41:data_tmp[3] <= data_tmp[3] + rs232_rx;
				7'd48, 7'd49, 7'd50:data_tmp[4] <= data_tmp[4] + rs232_rx;
				7'd57, 7'd58, 7'd59:data_tmp[5] <= data_tmp[5] + rs232_rx;
				7'd66, 7'd67, 7'd68:data_tmp[6] <= data_tmp[6] + rs232_rx;
				7'd75, 7'd76, 7'd77:data_tmp[7] <= data_tmp[7] + rs232_rx;
				7'd84, 7'd85, 7'd86:stop_bit <= stop_bit + rs232_rx;
				default:;
			endcase		
		end
//采样完成，产生输出信号
always@(posedge clk or negedge rst)
	if(!rst)
		rx_byte <= 8'd0;
	else if(bps_clk && bps_cnt == 7'd89)
		rx_byte <= {data_tmp[7][1],data_tmp[6][1],data_tmp[5][1],data_tmp[4][1],
						data_tmp[3][1],data_tmp[2][1],data_tmp[1][1],data_tmp[0][1]};
	else
		rx_byte <= rx_byte;
		
//产生采样时钟
rx_bps_gen rx_bps_gen(
	.clk(clk),
	.rst(rst),
	.baud_set(baud_set),
	.rx_done(rx_done),
	.byte_en(byte_en),
	.bps_clk(bps_clk)
);

assign byte_en = neg_rs232;
always@(posedge clk or negedge rst)
	if(!rst)
		rx_done <= 1'd0;
	else if(bps_clk && bps_cnt == 7'd89)
		rx_done <= 1'd1;
	else 
		rx_done <= 1'd0;
		
endmodule
