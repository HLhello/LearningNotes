module uart_tx_top(
	clk,
	rst,
	key_in,
	rs232_tx,
	led
);

input clk;
input rst;
input key_in;
output rs232_tx;
output led;

wire [7:0]data_byte;
wire key_flag;

issp	issps (
	.probe (  ),
	.source ( data_byte )
	);


key_filter key_filter(
	.clk(clk),
	.rst(rst),
	.key_in(key_in),
	.key_flag(key_flag),
	.key_state()
);

uart_byte_tx uart_byte_tx(
	.clk(clk),
	.rst(rst),
	.baud_set(3'd0),
	.data_byte(data_byte),
	.send_en(key_flag),
	.rs232_Tx(rs232_tx),
	.tx_done(),
	.uart_state(led),
	.bps_clk()
);


endmodule 
