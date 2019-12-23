module test_timing(
	clk,
	rst,
	led,
	sram_wreq,
	sram_waddr,
	sram_wdata,
	sram_rreq,
	sram_raddr,
	sram_rdata
);

input clk;
input rst;

output led;

output sram_wreq;
output [14:0]sram_waddr;
output [7:0]sram_wdata;

output sram_rreq;
output [14:0]sram_raddr;
input [7:0]sram_rdata;


endmodule 