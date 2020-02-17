`timescale 1ns/1ns
`define clk_period 20

module tb_sound_lut();
reg clk;
reg rst;

wire[31:0]cnt_max;

initial clk = 1'b0;
always#(`clk_period/2) clk = ~clk;

initial begin 
	rst = 1'b0;
	#(`clk_period*10)
	rst = 1'b1;
	#(200000000)
	$stop;
end

sound_lut lut(
	.clk(clk),
	.rst(rst),
	.cnt_max(cnt_max)
);
endmodule
