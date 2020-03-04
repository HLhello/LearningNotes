module led_pll(
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
wire rst_n;

plls	plls_inst (
	.areset ( !rst ),
	.inclk0 ( clk ),
	.c0 ( clk_12m5 ),
	.c1 ( clk_25m ),
	.c2 ( clk_50m ),
	.c3 ( clk_100m ),
	.locked ( rst_n )
);

led_light #(
	.cnt_max(27'd12_499_999)
	)led_light0(
	.clk(clk_12m5),
	.rst(rst_n),
	.led(led[0])
);
led_light #(
	.cnt_max(27'd24_999_999)
	)led_light1(
	.clk(clk_25m),
	.rst(rst_n),
	.led(led[1])
);
led_light #(
	.cnt_max(27'd49_999_999)
	)led_light2(
	.clk(clk_50m),
	.rst(rst_n),
	.led(led[2])
);
led_light #(
	.cnt_max(27'd99_999_999)
	)led_light3(
	.clk(clk_100m),
	.rst(rst_n),
	.led(led[3])
);


endmodule 

	



