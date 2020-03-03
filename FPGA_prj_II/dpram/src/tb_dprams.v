`timescale 1ns/1ns
`define clk_period 20

module tb_dprams();

reg clk;
reg [7:0]data;
reg [7:0]raddr;
reg [7:0]waddr;
reg wren;
wire [7:0]q;
integer i;
dprams	dprams (
	.clock ( clk ),
	.data ( data ),
	.rdaddress ( raddr ),
	.wraddress ( waddr ),
	.wren ( wren ),
	.q ( q )
);

initial clk = 1'b1;
always#(`clk_period/2) clk = ~clk;

initial begin 
	data = 0;
	raddr = 0;
	waddr = 0;
	wren = 0;
	i=0;
	#(`clk_period*20+1)
	for(i=0;i<=15;i=i+1)begin
		wren = 1;
		data = 255 - i;
		waddr = i;
		#`clk_period;
	end
	
	wren = 0;
	#(`clk_period*20)
	for(i=0; i<=15; i=i+1)begin
		raddr <= i;
		#`clk_period;
	end
	
	#(`clk_period*20);
	$stop;

end



endmodule
