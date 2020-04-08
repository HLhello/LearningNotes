module uart_scope(
	clk,
	rst,
	rs232_rx,
	rs232_tx,
	key_in,
	adc_sclk,
	adc_dout,
	adc_din,
	adc_cs_n,
	dac_sclk,
	dac_din,
	dac_cs_n
);

input clk;
input rst;

input rs232_rx;
output rs232_tx;

input [1:0]key_in;

output adc_sclk;
input adc_dout;
output adc_din;
output adc_cs_n;

output dac_sclk;
output dac_din;
output dac_cs_n;

uart_byte_rx uart_byte_rx(
	.clk(clk),
	.rst(rst),
	.baud_set(baud_set),
	.rs232_rx(rs232_rx),
	.rx_byte(),
	.rx_done(rx_done)
);

uart_byte_tx uart_byte_tx(
	.clk(clk),
	.rst(rst),
	.baud_set(baud_set),
	.byte_en(byte_en),
	.data_byte(),
	.tx_done(tx_done),
	.rs232_tx(rs232_tx)
);

cmd cmd(
	.clk(clk),
	.rst(rst),
	.rx_byte(),
	.rx_int(),
	.m_wr(),
	.m_addr(),
	.m_wrdata()
);

uart_tx_ctrl uart_tx_ctrl(
	.clk(),
	.rst(),
	.m_wr(),
	.m_addr(),
	.m_wrdata(),
	.adc_flag(),
	.adc_busy(),
	.byte_en(),
	.tx_done(),
	.baud_set()
);

sample_ctrl sample_ctrl(
	.clk(),
	.rst(),
	.m_wr(),
	.m_addr(),
	.m_wrdata(),
	.adc_en()
);

adc128s022 adc128s022(
	.clk(),
	.rst(),
	.channel(),
	.data(),
	.en_conv(),
	.conv_done(),
	.adc_state(),
	.div_parm(),
	.sclk(),
	.dout(),
	.din(),
	.cs_n()
);

dds dds(
	.clk(),
	.rst(),
	.m_wr(),
	.m_addr(),
	.m_wrdata(),
	.dds_data(),
	.dds_flag()
);

tlv5618 tlv5618(
	.clk(),
	.rst(),
	.dac_data(),
	.start(),
	.set_done(),
	.div_parm(),
	.cs_n(),
	.din(),
	.sclk(),
	.dac_state()
);

key_filter key_filter0(
	.clk(),
	.rst(),
	.key_in(),
	.key_flag(),
	.key_state()
);

key_filter key_filter1(
	.clk(),
	.rst(),
	.key_in(),
	.key_flag(),
	.key_state()
);



endmodule 
