`timescale 1ns/1ps
`define clk_period 20

module tb_fsm_welcome();

reg clk;
reg rst;
reg [7:0]data;

wire led;

fsm_welcome_IV fsm_welcome_IV(
	.clk(clk),
	.rst(rst),
	.data(data),
	.led(led)
);

initial clk = 1;
always #(`clk_period/2)  clk = ~clk;

initial begin 
	rst = 0;
	data = 0;
	#(`clk_period*20);
	rst = 1;
	#(`clk_period*20+1)
	forever begin	
		data = "I";
		#(`clk_period);
		data = "A";
		#(`clk_period);
		data = "H";
		#(`clk_period);
		data = "o";
		#(`clk_period);
		data = "H";
		#(`clk_period);
		data = "e";
		#(`clk_period);
		data = "L";
		#(`clk_period);
		data = "H";
		#(`clk_period);
		data = "e";
		#(`clk_period);
		data = "l";
		#(`clk_period);
		data = "l";
		#(`clk_period);
		data = "o";
		#(`clk_period);
		data = "M";
		#(`clk_period);
		data = "O";
		#(`clk_period);
	end
end

endmodule 
