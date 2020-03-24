module vga_ctrl(
	clk,
	rst,
	data_in,
	hcount,
	vcount,
	vga_rgb,
	vga_hs,
	vga_vs,
	vga_blk,
	vga_clk
);

parameter	vga_hs_end = 10'd95,
				vga_vs_end = 10'd1,
				hdat_begin = 10'd143,
				hdat_end = 10'd783,
				vdat_begin = 10'd34,
				vdat_end = 10'd514,
				hpixel_end = 10'd799,
				vline_end = 10'd524;

input clk;
input rst;
input [23:0]data_in;
output [9:0]hcount;
output [9:0]vcount;
output [23:0]vga_rgb;
output vga_hs;
output vga_vs;
output vga_blk;
output vga_clk;

assign vga_clk = ~clk;

reg [9:0]hcount_r;
always@(posedge clk or negedge rst)
	if(!rst)
		hcount_r <= 10'd0;
	else if(hcount_r == hpixel_end)
		hcount_r <= 10'd0;
	else 
		hcount_r <= hcount_r + 1'd1;
reg [9:0]vcount_r;
always@(posedge clk or negedge rst)
	if(!rst)
		vcount_r <= 10'd0;
	else if(hcount_r == hpixel_end)
		begin
			if(vcount_r == vline_end)
				vcount_r <= 10'd0;
			else 
				vcount_r <= vcount_r + 1'd1;
		end
	else 
		vcount_r <= vcount_r;
		
assign hcount = hcount_r - hdat_begin;
assign vcount = vcount_r - vdat_begin;

wire dat_act;
assign dat_act = ((hcount_r>=hdat_begin) && (hcount_r<hdat_end) && (vcount_r>=vdat_begin) && (vcount_r<vdat_end));
assign vga_blk = dat_act;

assign vga_hs = (hcount_r > vga_hs_end);
assign vga_vs = (vcount_r > vga_vs_end);
assign vga_rgb = dat_act? data_in : 24'h000000;

endmodule
