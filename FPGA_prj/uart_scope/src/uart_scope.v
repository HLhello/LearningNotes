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

input key_in;

output adc_sclk;
input adc_dout;
output adc_din;
output adc_cs_n;

output dac_sclk;
output dac_din;
output dac_cs_n;


endmodule 
