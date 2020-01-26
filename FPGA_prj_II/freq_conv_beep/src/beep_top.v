module beep_top(
	clk,
	rst,
	key,	
	beep
);

input clk;
input rst;
input key;

output beep;

reg cnt_going;//高点平计数，低电平停止计数
wire cnt_acc;
wire cnt_now;
wire full_flag;

freq_conv_beep beep0(
	.clk(clk),
	.rst(rst),
	.cnt_acc(cnt_acc),
	.mode(1'b1),
	.cnt_going(key),
	.cnt_now(cnt_now),
	.full_flag()
);

freq_conv_beep beep1(
	.clk(clk),
	.rst(rst),
	.cnt_acc(32'd1250000),
	.mode(1'b1),
	.cnt_going(1'b1),
	.cnt_now(),
	.full_flag(full_flag)
);

sound_lut sound_lut(
	.clk(full_flag),
	.rst(rst),
	.acc(cnt_acc)
);

assign beep = (cnt_now>= 24999)? 1'b1 : 1'b0;


endmodule
