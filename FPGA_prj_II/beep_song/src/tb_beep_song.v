`timescale 1ns/1ps
`define clk_period 20


module tb_beep_song();

reg clk;
reg rst;

wire beep;

initial clk = 1'b0;
always#(`clk_period/2) clk = ~clk;

initial begin 
	rst = 1'b0;
	#(`clk_period*10)
	rst = 1'b1;
	#(200000000)
	$stop;
end


beep_song u0(
	.clk_50m(clk),
	.rst_n(rst),
	.beep(beep)
);

endmodule
