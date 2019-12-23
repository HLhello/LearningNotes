module led_lighting(
	clk,
	rst,
	led
);

parameter cnt_msb = 24;

input clk;
input rst;

output led;

reg [(cnt_msb-1):0]cnt;

always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= 0;
	else
		cnt <= cnt+1'b1;

assign led = cnt[cnt_msb-1];


endmodule 
