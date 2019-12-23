`timescale 1ns/1ps
`define clk_period 20

module ctrl_led();

reg clk;
reg rst;
wire [3:0]led;

initial clk = 0;
always #(`clk_period) clk = ~clk;

initial begin 
	rst = 0;
	#(`clk_period*10);
	rst = 1;
	#10000000;
	$stop;
end

pllctrl_led pllctrl_led(
	.clk(clk),
	.rst(rst),
	.led(led)
);

endmodule

