`timescale 1ns/1ps
`define clk_period 20

module tb_disp_lcd();

reg clk;
reg rst;

wire lcd_light_en;
wire lcd_clk;
wire lcd_hsy;
wire lcd_vsy;
wire [4:0]lcd_r;
wire [5:0]lcd_g;
wire [4:0]lcd_b;

initial clk = 0;
always#(`clk_period) clk = ~clk;

initial begin 
	rst = 0;
	#(`clk_period*10);
	rst = 1;
	#10000000;
	$stop;
	$stop;
end



lcd_ctrl lcd_ctrl(
	.clk(clk),
	.rst(rst),
	.lcd_light_en(lcd_light_en),
	.lcd_clk(lcd_clk),
	.lcd_hsy(lcd_hsy),
	.lcd_vsy(lcd_vsy),
	.lcd_r(lcd_r),
	.lcd_g(lcd_g),
	.lcd_b(lcd_b)
);
endmodule