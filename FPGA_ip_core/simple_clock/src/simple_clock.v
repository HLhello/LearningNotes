module simple_clock(
	clk,
	rst,
	sel_digit,
	sel_seg
);

input clk;
input rst;

output [3:0]sel_digit;
output [7:0]sel_seg;

wire clk_25m;
wire rst_pll;
wire [15:0]disp_num;

pll	pll(
	.areset(!rst),
	.inclk0(clk),
	.c0(clk_25m),
	.locked(rst_pll)
);

sec_cnt	sec_cnt(
	.clk(clk_25m),
	.rst(rst_pll),
	.disp_num(disp_num)
);

ctrl_seg	ctrl_seg(
	.clk(clk_25m),
	.rst(rst_pll),
	.disp_num(disp_num),
	.sel_digit(sel_digit),
	.sel_seg(sel_seg)
);

endmodule 