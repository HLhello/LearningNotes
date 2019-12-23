module sram_wr(
	clk,
	rst,
	led,
	sram_cs_n,
	sram_we_n,
	sram_oe_n,
	sram_addr,
	sram_data
);

input clk;
input rst;

output led;
output sram_cs_n;
output sram_we_n;
output sram_oe_n;

output [14:0]sram_addr;
inout [7:0]sram_data;





endmodule
