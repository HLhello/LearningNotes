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

wire send_en;
wire [7:0]data_byte;
wire key_flag;
wire key_state;

wire clk_20m;
wire rst_pll;

assign send_en = key_flag & (!key_state);
pll	pll_inst (
	.areset ( !rst ),
	.inclk0 ( clk ),
	.c0 ( clk_20m ),
	.locked ( rst_pll )
	);

issp	issp_inst (
	.probe (  ),
	.source ( data_byte )
	);
	
xm_uart_tx xm_uart_tx(
	.clk(clk_20m),
	.rst(rst_pll),
	.baud_set(3'd4),
	.data_byte(data_byte),
	.send_en(send_en),
	.rs232_tx(rs232_tx),
	.tx_done(),
	.uart_state(led)
);

key_shake key_shake(
	.clk(clk_20m),
	.rst(rst_pll),
	.key_in(key_in),
	.key_flag(key_flag),
	.key_state(key_state)
);




endmodule

