module key_led_top(
	clk,
	rst,
	key_in0,
	key_in1,
	led
);

input clk;
input rst;
input key_in0;
input key_in1;

output [3:0]led;

wire key_flag0;
wire key_state0;
wire key_flag1;
wire key_state1;

key_filter key_filter0(
	.clk(clk),
	.rst(rst),
	.key_in(key_in0),
	.key_flag(key_flag0),
	.key_state(key_state0)
);

key_filter key_filter1(
	.clk(clk),
	.rst(rst),
	.key_in(key_in1),
	.key_flag(key_flag1),
	.key_state(key_state1)
);

led_ctrl led_ctrl(
	.clk(clk),
	.rst(rst),
	.key_flag_a(key_flag0),
	.key_state_a(key_state0),
	.key_flag_b(key_flag1),
	.key_state_b(key_state1),	
	.led(led)
);


endmodule 
