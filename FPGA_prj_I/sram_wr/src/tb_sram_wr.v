`timescale 1ns/1ps
`define clk_period 20
module tb_sram_wr();

reg clk;
reg rst;

wire led;
wire sram_cs_n;
wire sram_we_n;
wire sram_oe_n;

wire [14:0]sram_addr;
wire [7:0]sram_data;

initial clk = 0;
always #(`clk_period) clk = ~clk;

//assign sram_data = (!sram_we_n) ? 8'hzz : sram_data;

reg slink;
reg [7:0]sram_datar;

initial begin 
	rst = 1'b0;
	slink = 1'b0;
	#(`clk_period*10);
	rst = 1'b1;
	#200000000;
	$stop;
end 

always @(negedge sram_oe_n) begin
	slink <= 1;
	sram_datar <= sram_addr[7:0];
	@(posedge sram_cs_n);
	slink <= 0;
end  

assign sram_data = slink ? sram_datar:8'hzz;  

sram_wr sram_wr(
	.clk(clk),
	.rst(rst),
	.led(led),
	.sram_cs_n(sram_cs_n),
	.sram_we_n(sram_we_n),
	.sram_oe_n(sram_oe_n),
	.sram_addr(sram_addr),
	.sram_data(sram_data)
);



endmodule

