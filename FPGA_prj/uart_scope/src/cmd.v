module cmd(
	clk,
	rst,
	rx_byte,
	rx_int,
	m_wr,
	m_addr,
	m_wrdata
);

input clk;
input rst;
input [7:0]rx_byte;
input rx_int;
output m_wr;
output [7:0]m_addr;
output [15:0]m_wrdata;


endmodule 
