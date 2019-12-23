module sram_ctrl(
	clk,
	rst,
	sram_wreq,
	sram_waddr,
	sram_wdata,
	sram_rreq,
	sram_raddr,
	sram_rdata,
	sram_cs_n,
	sram_we_n,
	sram_oe_n,
	sram_addr,
	sram_data
);

input clk;
input rst;

input sram_wreq;
input [14:0]sram_waddr;
input [7:0]sram_wdata;
input sram_rreq;
input [14:0]sram_raddr;
output [7:0]sram_rdata;
output sram_cs_n;
output sram_we_n;
output sram_oe_n;
output sram_addr;
inout [7:0]sram_data;




endmodule
