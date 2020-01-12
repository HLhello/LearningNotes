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
output sram_cs_n;//片选信号 低电平有效
output sram_we_n;//写选通信号 低电平有效
output sram_oe_n;//输出选通信号 低电平有效

output [14:0]sram_addr;
inout [7:0]sram_data;

wire clk_50m;
wire rst_pll;

wire sram_wreq;
wire [14:0]sram_waddr;
wire [7:0]sram_wdata;

wire sram_rreq;
wire [14:0]sram_raddr;
wire [7:0]sram_rdata;

pll	pll(
	.areset(!rst),
	.inclk0(clk),
	.c0(clk_50m),
	.locked(rst_pll)
	);

test_timing	test_timing(
	.clk(clk_50m),
	.rst(rst_pll),
	.led(led),
	
	.sram_wreq(sram_wreq),
	.sram_waddr(sram_waddr),
	.sram_wdata(sram_wdata),
	
	.sram_rreq(sram_rreq),
	.sram_raddr(sram_raddr),
	.sram_rdata(sram_rdata)
);

sram_ctrl	sram_ctrl(
	.clk(clk_50m),
	.rst(rst_pll),
	
	.sram_wreq(sram_wreq),
	.sram_waddr(sram_waddr),
	.sram_wdata(sram_wdata),
	
	.sram_rreq(sram_rreq),
	.sram_raddr(sram_raddr),
	.sram_rdata(sram_rdata),
	
	.sram_cs_n(sram_cs_n),
	.sram_we_n(sram_we_n),
	.sram_oe_n(sram_oe_n),
	
	.sram_addr(sram_addr),
	.sram_data(sram_data)
);



endmodule
