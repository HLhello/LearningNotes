`timescale 1ns/1ns
`define clk_period 20

module tb_led_pll();

reg clk;
reg rst;

wire [3:0]led;

led_pll led_pll(
	.clk(clk),
	.rst(rst),
	.led(led)
);

initial clk = 1'd1;
always#(`clk_period/2) clk = ~clk;

initial begin
	rst = 1'd0;
	#(`clk_period*20);
	rst = 1'd1;
	#(`clk_period*2000000);
	
	$stop;

end



endmodule 
