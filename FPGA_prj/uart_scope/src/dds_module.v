module dds_module(
	clk,
	rst,
	en,
	fward,
	pward,
	da_clk,
	da_data
);

input clk;
input rst;
input en;
input [31:0]fward;
input [11:0]pward;
output da_clk;
output [9:0]da_data;


endmodule

