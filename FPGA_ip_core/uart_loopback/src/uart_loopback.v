module uart_loopback(
	clk,
	rst,
	
);

input clk;
input rst;

wire clk_25m;
wire rst_pll;

pll	pll_inst (
	.areset ( !rst ),
	.inclk0 ( clk ),
	.c0 ( clk_25m ),
	.locked ( rst_pll )
	);


endmodule 