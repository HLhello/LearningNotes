module beep_top(
	clk,
	rst,
	beep
);

input clk;
input rst;

output beep;

wire cnt_acc;
wire cnt_now;

freq_conv_beep beep0(
	.clk(clk),
	.rst(rst),
	.cnt_acc(cnt_acc),
	.mode(1'b1),
	.cnt_going(1'b1),
	.cnt_now(cnt_now),
	.full_flag()
);


sound_lut sound_lut(
	.clk(clk),
	.rst(rst),
	.acc(cnt_acc)
);

assign beep = (cnt_now >= (cnt_acc>>1))? 1'b1 : 1'b0;


endmodule
