module uart_byte_tx(
	clk,
	rst,
	baud_set,
	byte_en,
	data_byte,
	tx_done,
	rs232_tx
);

input clk;
input rst;
input [2:0]baud_set;
input byte_en;
input [7:0]data_byte;

output reg tx_done;
output reg rs232_tx;

wire bps_clk;
reg [7:0]data;
reg [3:0]bps_cnt;
tx_bps_gen tx_bps_gen(
	.clk(clk),
	.rst(rst),
	.baud_set(baud_set),
	.tx_done(tx_done),
	.byte_en(byte_en),
	.bps_clk(bps_clk)
);

//数据寄存，以免数据丢失
always@(posedge clk or negedge rst)
	if(!rst)
		data <= 8'd0;
	else if(bps_clk && bps_cnt == 4'd1)
		data <= data_byte;
	else 
		data <= data;
//计数波特率时钟
always@(posedge clk or negedge rst)
	if(!rst)
		bps_cnt <= 4'd0;
	else if(bps_cnt == 4'd11)
		bps_cnt <= 4'd0;
	else if(bps_clk)
		bps_cnt <= bps_cnt + 1'd1;
	else 
		bps_cnt <= bps_cnt;
//发送数据序列机
always@(posedge clk or negedge rst)
	if(!rst)
		rs232_tx <= 1'd1;
	else
		begin
			case(bps_cnt)
				4'd1 : rs232_tx <= 1'd0;
				4'd2 : rs232_tx <= data[0];
				4'd3 : rs232_tx <= data[1];
				4'd4 : rs232_tx <= data[2];
				4'd5 : rs232_tx <= data[3];
				4'd6 : rs232_tx <= data[4];
				4'd7 : rs232_tx <= data[5];
				4'd8 : rs232_tx <= data[6];
				4'd9 : rs232_tx <= data[7];
				4'd10: rs232_tx <= 1'd1;
				default rs232_tx <= 1'd1;
			endcase 
		end
	
//产生控制信号
always@(posedge clk or negedge rst)
	if(!rst)
		tx_done <= 1'd0;
	else if(bps_cnt == 4'd11)
		tx_done <= 1'd1;
	else 
		tx_done <= 1'd0;
		
endmodule 
