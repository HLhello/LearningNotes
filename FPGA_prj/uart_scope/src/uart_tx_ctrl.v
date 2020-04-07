module uart_tx_ctrl(
	clk,
	rst,
	m_wr,
	m_addr,
	m_wrdata,
	adc_flag,
	adc_busy,
	byte_en,
	tx_done,
	baud_set
);

input clk;
input rst;
input m_wr;
input [7:0]m_addr;
input [15:0]m_wrdata;
input adc_flag;
input adc_busy;
output reg byte_en;
input tx_done;
output reg [2:0]baud_set;
	
endmodule 
