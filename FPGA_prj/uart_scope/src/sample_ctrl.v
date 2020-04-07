module sample_ctrl(
	clk,
	rst,
	m_wr,
	m_addr,
	m_wrdata,
	adc_en
);

input clk,
input rst,
input m_wr,
input [7:0]m_addr,
input [15:0]m_wrdata,
output adc_en

endmodule 