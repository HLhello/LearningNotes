module led_cnt(
	clk,
	rst,
	led
);

parameter cnt_max = 25'd25_000_000;

input clk;
input rst;

output reg led;

reg [24:0]cnt;

always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= 25'd0;
	else if(cnt <cnt_max-1'b1)
		cnt <= cnt + 1'b1;
	else
		cnt <= 25'd0;

always@(posedge clk or negedge rst)
	if(!rst)
		led <= 1'b0;
	else if(cnt == cnt_max-1'b1)
		led <= ~led;
	
endmodule 
