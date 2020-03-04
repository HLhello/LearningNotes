module led_light(
	clk,
	rst,
	led
);

parameter cnt_max = 27'd99_999_999;

input clk;
input rst;
output led;

reg [26:0]cnt;

always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= 'd0;
	else if(cnt == cnt_max-1'd1)
		cnt <= 27'd0;
	else 
		cnt <= cnt + 1'd1;

assign led = (cnt > (cnt_max>>1'd1)) ? 1'd1: 1'd0;

endmodule 
