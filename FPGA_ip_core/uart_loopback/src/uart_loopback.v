module uart_loopback(
	clk,
	rst,
	tx_data,
	rx_data
);

input clk;
input rst;

input [7:0]tx_data;
output [7:0]rx_data;

wire clk_25m;
wire rst_pll;

wire bps_start_rx;
wire bps_hf_rx;
wire bps_start_tx;
wire bps_hf_tx;

wire rx_intr;

pll	pll_inst (
	.areset ( !rst ),
	.inclk0 ( clk ),
	.c0 ( clk_25m ),
	.locked ( rst_pll )
	);

speed_setting	speed_rx(
	.clk(clk_25m),
	.rst(rst_pll),
	.bps_start(bps_start_rx),
	.bps_hf(bps_hf_rx)
);	

uart_rx	uart_rx_u(
	.clk(clk_25m),
	.rst(rst_pll),
	.bps_start(bps_start_rx),
	.bps_hf(bps_hf_rx),
	.rx_intr(rx_intr),
	.uart_rx(uart_tx),
	.rx_data(rx_data)
);

speed_setting	speed_tx(
	.clk(clk_25m),
	.rst(rst_pll),
	.bps_start(bps_start_tx),
	.bps_hf(bps_hf_tx)
);	

uart_tx	uart_tx_u(
	.clk(clk_25m),
	.rst(rst_pll),
	.bps_start(bps_start_tx),
	.bps_hf(bps_hf_tx),
	.rx_intr(rx_intr),	
	.rx_data(tx_data),
	.uart_tx(uart_tx)
);



endmodule 