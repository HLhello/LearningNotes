module tft_ctrl(
	clk,
	rst,
	data_in,
	vcount,
	hcount,
	tft_rgb,
	tft_vs,
	tft_hs,
	tft_clk,
	tft_pwm,
	tft_de
);
//480*272
parameter	tft_hs_end = 10'd40,
				tft_vs_end = 10'd9,
				hdat_begin = 10'd42,
				hdat_end = 10'd522,
				vdat_begin = 10'd11,
				vdat_end = 10'd283,
				hpixel_end = 10'd524,
				vline_end = 10'd285;
				
input clk;
input rst;
input [15:0]data_in;
output [9:0]vcount;
output [9:0]hcount;
output [15:0]tft_rgb;
output tft_vs;
output tft_hs;
output tft_clk;
output tft_pwm;
output tft_de;


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
	else if(hcount_r==hpixel_end)
		begin
			if(vcount_r==vline_end)
				vcount_r <= 10'd0;
			else 
				vcount_r <= vcount_r + 1'd1;
		end
	else 
		vcount_r <= vcount_r;

assign tft_hs = (hcount_r>tft_hs_end)? 1'd1 : 1'd0;
assign tft_vs = (vcount_r>tft_vs_end)? 1'd1 : 1'd0;

wire dat_act;
assign dat_act = ((hcount_r>=hdat_begin)&&(hcount_r<hdat_end)&&(vcount_r>=vdat_begin)&&(vcount_r<vdat_end));
assign tft_rgb = dat_act? data_in : 16'h0000;
assign hcount = hcount_r - hdat_begin;
assign vcount = vcount_r - vdat_begin;

assign tft_clk = clk;
assign tft_pwm = rst;
assign tft_de = dat_act;




endmodule

