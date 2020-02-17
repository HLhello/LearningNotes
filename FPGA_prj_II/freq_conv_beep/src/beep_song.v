module beep_song(
	clk,
	rst,
	beep
);

input clk;
input rst;

output beep;

wire [31:0]cnt_now;
wire [31:0]cnt_acc;
wire tempo;


freq_conv_beep music_note(

	.clk(clk),
	.rst(rst),
	
	.cnt_acc(cnt_acc),
	.mode(1'b1),	
	.cnt_going(1'b1),
	
	.cnt_now(cnt_now),
	.full_flag()	
);

sound_lut sound_lut(
	.clk(tempo),
	.rst(rst),
	.acc(cnt_acc)
);

//250ms定时，用于切换音调
freq_conv_beep music_tempo(

	.clk(clk),
	.rst(rst),
	
	.cnt_acc(32'd12500000),
	.mode(1'b1),	
	.cnt_going(1'b1),
	
	.cnt_now(),
	.full_flag(tempo)	
);

	
assign beep = (cnt_now >= (cnt_acc>>1'b1))?1'b1:1'b0;

endmodule