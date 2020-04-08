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

//产生采样时钟
reg byte_en;
wire bps_clk; 
rx_bps_gen rx_bps_gen(
	.clk(clk),
	.rst(rst),
	.baud_set(baud_set),
	.rx_done(rx_done),
	.byte_en(byte_en),
	.bps_clk(bps_clk)
);

//过滤毛刺
reg rs232_rx0, rs232_rx1, rs232_rx2, rs232_rx3;
always@(posedge clk or negedge rst)
	if(!rst)
		begin
			rs232_rx0 <= 1'd0;rs232_rx;
			rs232_rx1 <= 1'd0;rs232_rx0;
			rs232_rx2 <= 1'd0;rs232_rx1;
			rs232_rx3 <= 1'd0;rs232_rx2;
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

//采样完成，产生输出信号

endmodule
