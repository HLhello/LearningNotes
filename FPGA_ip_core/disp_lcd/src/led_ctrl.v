module led_ctrl(
	clk,
	rst,
	led
);

input clk;
input rst;

output reg led;

reg [23:0]cnt;
always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= 24'd0;
	else 
		cnt <= cnt + 1'b1;


always@(posedge clk or negedge rst)
	if(!rst)
		led <= 1'b0;
	else if(cnt[23] == 1'b1)
		led <= ~led;
endmodule
