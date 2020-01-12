module disp_lcd(
	clk,
	rst,
	led,
	lcd_light_en,
	lcd_clk,
	lcd_hsy,
	lcd_vsy,
	lcd_r,
	lcd_g,
	lcd_b
);

input clk;
input rst;

output led;
output lcd_light_en;
output lcd_clk;
output lcd_hsy;
output lcd_vsy;
output [4:0]lcd_r;
output [5:0]lcd_g;
output [4:0]lcd_b;

pll	pll_inst (
	.areset ( !rst ),
	.inclk0 ( clk ),
	.c0 ( clk_25m ),
	.locked ( rst_pll )
	);

	
led_ctrl(
	.clk(clk_25m),
	.rst(rst_pll),
	.led(led)
);

lcd_ctrl(
	.clk(clk_25m),
	.rst(rst_pll),
	.lcd_light_en(lcd_light_en),
	.lcd_clk(lcd_clk),
	.lcd_hsy(lcd_hsy),
	.lcd_vsy(lcd_vsy),
	.lcd_r(lcd_r),
	.lcd_g(lcd_g),
	.lcd_b(lcd_b)
);

endmodule
