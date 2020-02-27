module led_ctrl(
	clk,
	rst,
	key_flag_a,
	key_state_a,
	key_flag_b,
	key_state_b,	
	led
);

input clk;
input rst;
input key_flag_a;
input key_state_a;
input key_flag_b;
input key_state_b;

output reg [3:0]led;

always@(posedge clk or negedge rst)
	if(!rst)
		led <= 4'd0;
	else if(key_flag_a)
		led <= led + 1'd1;
	else if(key_flag_b)
		led <= led - 1'd1;
	else 
		led <= led;
		
endmodule