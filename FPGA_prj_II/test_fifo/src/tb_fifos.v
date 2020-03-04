`timescale 1ns/1ns
`define clk_period 20

module tb_fifos();

reg clk;
reg rst;
reg [15:0]data;
reg rdreq;
reg sclr;
reg wrreq;

wire almost_empty;
wire almost_full;
wire empty;
wire full;
wire [15:0]  q;
wire [7:0]  usedw;

integer i;

fifos	fifos_inst (
	.clock ( clk ),
	.data ( data ),
	.rdreq ( rdreq ),
	.sclr ( sclr ),
	.wrreq ( wrreq ),
	.almost_empty ( almost_empty ),
	.almost_full ( almost_full ),
	.empty ( empty ),
	.full ( full ),
	.q ( q ),
	.usedw ( usedw )
	);

initial clk = 1'd1;
always#(`clk_period/2) clk = ~clk;
	
initial begin
	rst = 1'd0;
	//initial register
	data = 0;
	rdreq = 0;
	sclr = 0;
	wrreq = 0;
	i = 0;
	#(`clk_period*20);
	rst = 1'd1;
	//testbench
	for(i=0;i<=255;i=i+1)begin
		wrreq = 1;
		data = i;
		#`clk_period;
	end
	wrreq = 0;
	#(`clk_period*20);
	for(i=0;i<=255;i=i+1)begin
		rdreq = 1;
		#`clk_period;
	end
	
	rdreq = 0;
	#(`clk_period*20);
	$stop;
end


endmodule
