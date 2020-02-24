`timescale 1ns/1ps
`define clk_period 20

module tb_counter();

reg cin;
reg clk;

wire cout;
wire [7:0]q;


initial clk = 1'b1;
always #(`clk_period/2) clk = ~clk;

initial begin
	repeat(20)begin
		cin = 0;
		#(`clk_period*5) cin = 1;
		#(`clk_period) cin = 0;
	end
	#(`clk_period*500);
	$stop;
end

double_counter cnt0 (
	.cin ( cin ),
	.clk ( clk ),
	.cout ( cout ),
	.q ( q )
	);
endmodule 
