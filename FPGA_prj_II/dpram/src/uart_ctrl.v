module uart_ctrl(
	clk,
	rst,
	key_flag,
	key_state,
	rx_done,
	tx_done,
	wren,
	waddr,
	raddr,
	send_en
);

input clk;
input rst;
input key_flag;
input key_state;
input rx_done;
input tx_done;
output reg wren;
output reg [7:0]waddr;
output reg [7:0]raddr;
output reg send_en;

always@(posedge clk or negedge rst)
	if(!rst)
		wren <= 1'd0;
	else if(rx_done)
		wren <= 1'd1;
	else 
		wren <= 1'd0;
		
always@(posedge clk or negedge rst)
	if(!rst)
		waddr <= 8'd255;
	else if(rx_done)
		waddr <= waddr + 1'd1;
	else
		waddr <= waddr;


reg send,send_tmp;
always@(posedge clk or negedge rst)
	if(!rst)
		send <= 1'd0;
	else if(key_flag)
		send <= 1'd1;
	else 
		send <= 1'd0;

always@(posedge clk)
	send_tmp <=send;
always@(posedge clk)
	send_en <=send_tmp;
		
always@(posedge clk or negedge rst)
	if(!rst)
		raddr <= 8'd255;
	else if(send_en)
		raddr <= raddr + 1'd1;
	else 
		raddr <= raddr;
		

		
endmodule 
