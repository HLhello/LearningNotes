`timescale 1ns/1ns
`define clk_period 40

module tb_vga_ctrl();

reg clk;
reg rst;
reg [23:0]data_in;
wire [9:0]hcount;
wire [9:0]vcount;
wire [23:0]vga_rgb;
wire vga_hs;
wire vga_vs;
wire vga_blk;
wire vga_clk;

vga_ctrl vga_ctrl(
	.clk(clk),
	.rst(rst),
	.data_in(data_in),
	.hcount(hcount),
	.vcount(vcount),
	.vga_rgb(vga_rgb),
	.vga_hs(vga_hs),
	.vga_vs(vga_vs),
	.vga_blk(vga_blk),
	.vga_clk(vga_clk)
);

initial clk = 1'd1;
always#(`clk_period/2) clk = ~clk;

initial begin
	rst = 1'd0;
	data_in = 24'h000000;
	#(`clk_period*10)
	rst = 1'd1;
	data_in = 24'hffffff;
end
reg [3:0]v_cnt=0;
initial begin
	wait(v_cnt == 3);
	$stop;
end
always@(posedge vga_vs)
	v_cnt <= v_cnt + 1'd1;
	
endmodule 