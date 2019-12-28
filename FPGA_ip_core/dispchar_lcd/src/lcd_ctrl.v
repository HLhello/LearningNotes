module lcd_ctrl(
	clk,
	rst,
	lcd_light_en,
	lcd_clk,
	lcd_hsy,
	lcd_vsy,
	lcd_r,
	lcd_g,
	lcd_b,
	rom_data,
	rom_addr
);

input clk;
input rst;

output lcd_light_en;
output lcd_clk;
output lcd_hsy;
output lcd_vsy;
output [4:0]lcd_r;
output [5:0]lcd_g;
output [4:0]lcd_b;

input [31:0]rom_data;
output [5:0]rom_addr;

endmodule 
