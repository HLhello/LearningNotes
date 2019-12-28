`define cnt_msb 24

module led_ctrl(
	clk,
	rst,
	led
);

input clk;
input rst;

output led;

reg [`cnt_msb-1:0]cnt;

always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= `cnt_msb'd0;
	else 
		cnt <= cnt + 1'b1;
		
assign led = cnt[`cnt_msb-1];	
	
endmodule
