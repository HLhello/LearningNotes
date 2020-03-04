`timescale 1ns/1ns
`define clk_period 20
`define wrclk_period 20
`define rdclk_period 10

module tb_dualclk_fifos();

reg wrclk;
reg rdclk;
reg [15:0]  data;
reg   rdreq;
reg   wrreq;
wire [7:0]  q;
wire   rdempty;
wire [8:0]  rdusedw;
wire   wrfull;
wire [7:0]  wrusedw;
integer i;

dualclk_fifos	dualclk_fifos_inst (
	.data ( data ),
	.rdclk ( rdclk ),
	.rdreq ( rdreq ),
	.wrclk ( wrclk ),
	.wrreq ( wrreq ),
	.q ( q ),
	.rdempty ( rdempty ),
	.rdusedw ( rdusedw ),
	.wrfull ( wrfull ),
	.wrusedw ( wrusedw )
	);
reg clk;
initial clk = 1'd1;
always#(`clk_period/2) clk = ~clk;

initial wrclk = 1'd1;
always#(`wrclk_period/2) wrclk = ~wrclk;

initial rdclk = 1'd1;
always#(`rdclk_period/2) rdclk = ~rdclk;

initial begin
	//initial register
	data = 0;
	rdclk = 0;
	rdreq = 0;
	wrclk = 0;
	wrreq = 0;
	i=0;
	#(`wrclk_period*20);
	//testbench
		for(i=0;i<=255;i=i+1)begin
		wrreq = 1;
		data = i;
		#`wrclk_period;
	end
	wrreq = 0;
	#(`rdclk_period*20);
	for(i=0;i<=511;i=i+1)begin
		rdreq = 1;
		#`rdclk_period;
	end
	
	rdreq = 0;
	#(`wrclk_period*20);
	$stop;
	
end


endmodule
