module pll_ctrl_led(
	clk,
	rst,
	led
);

input clk;
input rst;

output [3:0]led;

wire clk_12m5;
wire clk_25m;
wire clk_50m;
wire clk_100m;
wire rst_pll;

pll pll_gen (
	.areset ( !rst ),
	.inclk0 ( clk ),
	.c0 ( clk_12m5 ),
	.c1 ( clk_25m ),
	.c2 ( clk_50m ),
	.c3 ( clk_100m ),
	.locked ( rst_pll )
	);

led_lighting #(10)led0(
	.clk(clk_12m5),
	.rst(rst_pll),
	.led(led[0])
);

led_lighting #(11) led1(
	.clk(clk_25m),
	.rst(rst_pll),
	.led(led[1])
);

led_lighting #(12)led2(
	.clk(clk_50m),
	.rst(rst_pll),
	.led(led[2])
);

led_lighting #(26)led3(
	.clk(clk_100m),
	.rst(rst_pll),
	.led(led[3])
);


endmodule 