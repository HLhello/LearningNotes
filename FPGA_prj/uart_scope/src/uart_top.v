module uart_top(
	clk,
	rst,
	key_in,
	rs232_tx,
	rs232_rx
);
input clk;
input rst;
input key_in;
output rs232_tx;
input rs232_rx;

wire key_flag;
wire key_state;
key_filter key_filter(
	.clk(clk),
	.rst(rst),
	.key_in(key_in),
	.key_flag(key_flag),
	.key_state(key_state)
);

wire [2:0]baud_set;
assign baud_set = 3'd0;

wire byte_en;
assign byte_en = key_flag && !key_state;

wire [7:0]data_tx;
uart_byte_tx uart_byte_tx(
	.clk(clk),
	.rst(rst),
	.baud_set(baud_set),
	.byte_en(byte_en),
	.data_byte(data_tx),
	.tx_done(),
	.rs232_tx(rs232_tx)
);

wire [7:0]data_rx;
uart_byte_rx uart_byte_rx(
	.clk(clk),
	.rst(rst),
	.baud_set(baud_set),
	.rs232_rx(rs232_rx),
	.rx_byte(data_rx),
	.rx_done()
);

issp	issp (
	.probe ( data_rx ),
	.source ( data_tx )
	);

endmodule 
