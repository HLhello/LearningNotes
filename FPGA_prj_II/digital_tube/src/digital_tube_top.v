module digital_tube_top(
	clk,
	rst,
	sh_cp,
	st_cp,
	ds
);

input clk;
input rst;
output sh_cp;
output st_cp;
output ds;

wire [31:0]disp_data;
wire [7:0]sel;
wire [6:0]seg;

hex_data	hex_data (
	.probe (  ),
	.source ( disp_data )
	);

HC595_Diver HC595_Diver(
	.clk(clk),
	.rst(rst),
	.data_in({1'b1,seg,sel}),
	.en(1'b1),
	.ds(ds),
	.sh_cp(sh_cp),
	.st_cp(st_cp)
);

digital_tube digital_tube(
	.clk(clk),
	.rst(rst),
	.disp_data(disp_data),
	.en(1'b1),
	.seg(seg),
	.sel(sel)
);

endmodule 
