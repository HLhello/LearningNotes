module uart_rx(
	clk,
	rst,
	bps_start,
	bps_hf,
	rx_intr,
	uart_rx,
	rx_data
);

input clk;
input rst;

output bps_start;
input bps_hf;
output rx_intr;
//1bit 转换成8bits
input uart_rx;
output [7:0] rx_data;


//使用下面方法检测下降沿可以过滤掉<40ns的毛刺-->为什么？
//利用资源换取稳定（对时间要求不是很苛刻，因为输入信号打了好几拍）
//条件是有效低脉冲是远远大于80ns的
/*A*/
reg uart_rx0,uart_rx1,uart_rx2,uart_rx3;
wire neg_uart_rx;
always@(posedge clk or negedge rst)
	if(!rst)
		begin
			uart_rx0 <= 1'b0;
			uart_rx1 <= 1'b0;
			uart_rx2 <= 1'b0;
			uart_rx3 <= 1'b0;
		end
	else 
		begin
			uart_rx0 <= uart_rx;
			uart_rx1 <= uart_rx0;
			uart_rx2 <= uart_rx1;
			uart_rx3 <= uart_rx2;
		end
assign neg_uart_rx = uart_rx3 & uart_rx2 & (~uart_rx1) & (~uart_rx0);

/*B
reg [3:0] uart_rx_r;
wire wire neg_uart_rx;
always@(posedge clk or negedge rst)
	if(!rst)
		uart_rx_r <= 4'b0;
	else 
		uart_rx_r <= {uart_rx_r[2:0],uart_rx};
//可不可以用其他逻辑表达式代替上式，比如异或什么的
assign neg_uart_rx = uart_rx_r[3] & uart_rx_r[3] & (~uart_rx_r[1]) & (~uart_rx_r[0]);
*/

reg bps_start_r;
reg [3:0]num;
reg rx_intr;

always@(posedge clk or negedge rst)
	if(!rst)
		begin
			bps_start_r <= 1'bz;//这为什么是高阻态呢？
			rx_intr <= 1'b0;
		end
	else if(neg_uart_rx)
		begin
			bps_start_r <= 1'b1;
			rx_intr <= 1'b1;
		end
	else if(num == 4'd9)
		begin
			bps_start_r <= 1'b0;
			rx_intr <= 1'b0;
		end
assign bps_start = bps_start_r;//这样做有什么好处么？TODO

reg [7:0] rx_data_r;
reg [7:0] rx_temp_data;
/*A我觉的这段代码写的不好，ifelse嵌套太多*/
always@(posedge clk or negedge rst)
	if(!rst)
		begin
			num <= 4'b0;
			rx_temp_data <= 8'd0;
			rx_data_r <= 8'd0;
		end
	else if(rx_intr)
		begin
			if(bps_hf)
				begin//仿真仔细观察这几个信号
					num <= num +1'b1;
					case(num)
						4'd1:rx_temp_data[0] <= uart_rx; 
						4'd2:rx_temp_data[1] <= uart_rx; 
						4'd3:rx_temp_data[2] <= uart_rx; 
						4'd4:rx_temp_data[3] <= uart_rx; 
						4'd5:rx_temp_data[4] <= uart_rx; 
						4'd6:rx_temp_data[5] <= uart_rx; 
						4'd7:rx_temp_data[6] <= uart_rx; 
						4'd8:rx_temp_data[7] <= uart_rx; 
						default:;
					endcase
				end
			else if(num == 4'd9)
				begin
					num <= 4'd0;
					rx_data_r <= rx_temp_data;
				end
		end
/*B
always@(posedge clk or negedge rst)
	if(!rst)
		num <= 4'd0;
	else if(num == 4'd9)
		num <= 4'd0;
	else if(rx_intr && bps_hf)
		num <= num + 1'b1;

always@(posedge clk or negedge rst)
	if(!rst)
		rx_temp_data <= 8'd0;
	else if(rx_intr && bps_hf)
		begin
			case(num)
				4'b1:rx_temp_data[0] <= uart_rx; 
				4'b2:rx_temp_data[1] <= uart_rx; 
				4'b3:rx_temp_data[2] <= uart_rx; 
				4'b4:rx_temp_data[3] <= uart_rx; 
				4'b5:rx_temp_data[4] <= uart_rx; 
				4'b6:rx_temp_data[5] <= uart_rx; 
				4'b7:rx_temp_data[6] <= uart_rx; 
				4'b8:rx_temp_data[7] <= uart_rx; 
				default:;
			endcase
		end

always@(posedge clk or negedge rst)
	if(!rst)
		rx_data_r <= 8'd0;
	else if(num==4'd9)
		rx_data_r <= rx_temp_data;
*/
assign rx_data = rx_data_r;

endmodule 