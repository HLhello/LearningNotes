module ctrl_led(
	clk,
	rst,
	key,
	led1,
	led2
);

input clk;
input rst;
input key;

output reg led1;
output reg led2;

wire key_flag;
wire key_state;

always@(posedge clk or negedge rst)
	if(!rst)
		led1 <= 1'b0;
	else if(key_flag)
		led1 <= ~led1;
		
always@(posedge clk or negedge rst)
	if(!rst)
		led2 <= 1'b0;
	else if(key_state)
		led2 <= ~led2;

key_shake key_0(
	.clk(clk),
	.rst(rst),
	.key_in(key),
	.key_flag(key_flag),
	.key_state(key_state)
);

endmodule
