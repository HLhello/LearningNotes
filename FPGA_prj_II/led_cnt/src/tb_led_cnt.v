`timescale 1ns/1ps
`define clk_period 20


module tb_led_cnt();

reg clk;
reg rst;

wire led;


initial clk = 1'b1;
always #(`clk_period/2) clk = ~clk;

initial begin
	rst = 1'b1;
	#200;
	rst = 1'b0;
	#200;
	rst = 1'b1;
	#20_000;
	$stop;
end


led_cnt led_cnt(
	.clk(clk),
	.rst(rst),
	.led(led)
);
endmodule 
