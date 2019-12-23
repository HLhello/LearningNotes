`timescale 1ns/1ps
`define clk_period 20

module tb_simple_clock();

reg clk;
reg rst;

wire [3:0]sel_digit;
wire [7:0]sel_seg;

initial clk = 0;
always #(`clk_period) clk = ~clk;

initial begin
	rst = 0;
	#(`clk_period*10)
	rst = 1;
	#10000000;
	$stop;
end


simple_clock simple_clock(
	.clk(clk),
	.rst(rst),
	.sel_digit(sel_digit),
	.sel_seg(sel_seg)
);

endmodule
