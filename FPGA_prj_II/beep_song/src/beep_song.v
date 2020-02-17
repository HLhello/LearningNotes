module beep_song(
	clk_50m,
	rst_n,
	beep
);

input clk_50m;
input rst_n;

output beep;

wire clk;
wire rst;
wire pause;
wire [31:0]cnt_max;
wire [31:0]cnt_now;
wire full_flag;

pll	pll_inst (
	.areset ( !rst_n ),
	.inclk0 ( clk_50m ),
	.c0 ( clk ),
	.locked ( rst )
	);

	
freq_cnter music_note(
	.clk(clk),
	.rst(rst),
	.mode(1'b1),
	.pause(1'b1),
	.cnt_max(cnt_max),
	.cnt_now(cnt_now),
	.full_flag()
);

//节拍计时
freq_cnter music_tempo(
	.clk(clk),
	.rst(rst),
	.mode(1'b1),
	.pause(1'b1),
	.cnt_max(32'd12500000),
	.cnt_now(),
	.full_flag(full_flag)
);

sound_lut sound_lut(
	.clk(full_flag),
	.rst(rst),
	.cnt_max(cnt_max)
);

assign beep = (cnt_now<(cnt_max>>1'b1))? 1'b0 : 1'b1;

endmodule


