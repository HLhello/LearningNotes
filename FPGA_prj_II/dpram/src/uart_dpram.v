module uart_dpram(
	clk,
	rst,
	key_in,
	rs232_rx,
	rs232_tx
);
input clk;
input rst;
input key_in;
input rs232_rx;
output rs232_tx;

wire key_flag, key_state;
wire tx_done, rx_done;
wire wren;
wire [7:0]waddr, raddr;
wire send_en;
wire [7:0]rx_data,tx_data;

uart_ctrl uart_ctrl(
	.clk(clk),
	.rst(rst),
	.key_flag(key_flag),
	.key_state(key_state),
	.rx_done(rx_done),
	.tx_done(tx_done),
	.wren(wren),
	.waddr(waddr),
	.raddr(raddr),
	.send_en(send_en)
);

key_filter key_filter(
	.clk(clk),
	.rst(rst),
	.key_in(key_in),
	.key_flag(key_flag),
	.key_state(key_state)
);


uart_rx uart_rx(
	.clk(clk),
	.rst(rst),
	.baud_set(3'd0),
	.rs232_rx(rs232_rx),
	.data_byte(rx_data),
	.rx_done(rx_done)
);

uart_tx_I uart_tx_I(
	.clk(clk),
	.rst(rst),
	.baud_set(3'd0),
	.data_byte(tx_data),
	.send_en(send_en),
	.rs232_Tx(rs232_tx),
	.tx_done(tx_done),
	.uart_state(),
	.bps_clk()
);

dprams	dprams (
	.clock ( clk ),
	.data ( rx_data ),
	.rdaddress ( raddr ),
	.wraddress ( waddr ),
	.wren ( wren ),
	.q ( tx_data )
);

endmodule
