`include "header.v"

module dds(
	clk,
	rst,
	m_wr,
	m_addr,
	m_wrdata,
	dds_data,
	dds_flag
);

input clk;
input rst;
input m_wr;
input [7:0]m_addr;
input [15:0]m_wrdata;
output [11:0]dds_data;
output reg dds_flag;

dds_module dds_module(
	.clk(),
	.rst(),
	.en(),
	.fward(),
	.pward(),
	.da_clk(),
	.da_data()
);


endmodule 

