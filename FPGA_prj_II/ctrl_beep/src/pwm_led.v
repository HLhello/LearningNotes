module pwm_led(
	clk,
	rst,
	led
);

input clk;
input rst;
output reg [3:0]led;

reg [1:0]cnt;

always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= 2'd0;
	else
		cnt <= cnt + 1'd1;

always@(posedge clk or negedge rst)
	if(!rst)
		led[0] <= 1'd0;
	else
		led[0] <= 1'd0;
		
always@(posedge clk or negedge rst)
	if(!rst)
		led[1] <= 1'd0;
	else if(cnt < 2'd1)
		led[1] <= 1'd1;
	else
		led[1] <= 1'd0;

always@(posedge clk or negedge rst)
	if(!rst)
		led[2] <= 1'd0;
	else if(cnt < 2'd2)
		led[2] <= 1'd1;
	else
		led[2] <= 1'd0;

always@(posedge clk or negedge rst)
	if(!rst)
		led[3] <= 1'd0;
	else if(cnt < 2'd3)
		led[3] <= 1'd1;
	else 
		led[3] <= 1'd0;



endmodule 
