`timescale 1ns/1ns
`define clk_period 20

module tb_digital_tube();

reg clk;
reg rst;
reg [31:0]disp_data;
reg en;
wire [6:0]seg;
wire [7:0]sel;

digital_tube digital_tube(
	.clk(clk),
	.rst(rst),
	.disp_data(disp_data),
	.en(en),
	.seg(seg),
	.sel(sel)
);

initial clk = 1'b1;
always#(`clk_period/2) clk = ~clk;

initial begin
	rst = 1'b0;
	disp_data = 32'd0;
	en = 1'b1;
	#(`clk_period*20)
	rst = 1'b1;
	#20000000;
	disp_data = 32'h01234567;
	#20000000;
	disp_data = 32'h89abcdef;
	#20000000;
	$stop;
end


endmodule
