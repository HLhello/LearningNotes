`timescale 1ns/1ns
`define clk_period 20

module tb_roms();

reg clk;
reg [7:0]addr;
wire [7:0]q;
integer i;

roms	roms_inst (
	.address ( addr ),
	.clock ( clk ),
	.q ( q )
	);

initial clk = 1;
always#(`clk_period/2) clk = ~clk;

initial begin
	for(i=0; i<=2550; i=i+1)begin
		addr = i;
		#(`clk_period);
	end
	
	#(`clk_period*50);
	$stop;

end
	
endmodule 


