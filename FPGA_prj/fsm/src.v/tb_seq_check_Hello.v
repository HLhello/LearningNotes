`timescale 1ns/1ns
`define clk_period 20

module tb_seq_check_Hello();

reg clk;
reg rst;
reg [7:0]x;
wire led;

seq_check_hello seq_check(
	.clk(clk),
	.rst(rst),
	.din(x),
	.dout(led)
);

initial clk = 1'b1;
always#(`clk_period/2) clk = ~clk;

initial begin
	rst = 1'b0;
	x = "x";
	#(`clk_period*5);
	rst = 1'b1;
	
	#(`clk_period*5 + 1);
	
	#(`clk_period);
	x = "I";
	#(`clk_period);
	x = "A";
	#(`clk_period);
	x = "M";
	
	#(`clk_period);
	x = "H";
	#(`clk_period);
	x = "e";
	#(`clk_period);
	x = "l";
	#(`clk_period);
	x = "l";
	#(`clk_period);
	x = "o";
	
	#(`clk_period);
	x = "H";
	
	#(`clk_period);
	x = "H";
	#(`clk_period);
	x = "e";
	#(`clk_period);
	x = "l";
	#(`clk_period);
	x = "l";
	#(`clk_period);
	x = "o";
	
	#(`clk_period);
	x = "H";
	#(`clk_period);
	x = "e";
	
	#(`clk_period);
	x = "H";
	#(`clk_period);
	x = "e";
	#(`clk_period);
	x = "l";
	#(`clk_period);
	x = "l";
	#(`clk_period);
	x = "o";
	
	#(`clk_period);
	x = "H";
	#(`clk_period);
	x = "a";
	#(`clk_period);
	x = "i";
	#(`clk_period);
	x = "l";
	#(`clk_period);
	x = "o";
	
	#(`clk_period);
	x = "H";
	#(`clk_period);
	x = "e";
	#(`clk_period);
	x = "l";
	
	#(`clk_period);
	x = "H";
	#(`clk_period);
	x = "e";
	#(`clk_period);
	x = "l";
	#(`clk_period);
	x = "l";
	#(`clk_period);
	x = "o";
	
	#(`clk_period);
	x = "H";
	#(`clk_period);
	x = "e";
	#(`clk_period);
	x = "l";
	#(`clk_period);
	x = "l";
	
	#(`clk_period);
	x = "H";
	#(`clk_period);
	x = "e";
	#(`clk_period);
	x = "l";
	#(`clk_period);
	x = "l";
	#(`clk_period);
	x = "o";
	
	#(`clk_period);
	x = "l";
	#(`clk_period);
	x = "o";
	#(`clk_period);
	x = "H";
	#(`clk_period);
	x = "H";
	
	#(`clk_period);
	x = "H";
	#(`clk_period);
	x = "e";
	#(`clk_period);
	x = "l";
	#(`clk_period);
	x = "l";
	
	#(`clk_period);
	x = "H";
	#(`clk_period);
	x = "e";
	#(`clk_period);
	x = "l";
	#(`clk_period);
	x = "l";
	#(`clk_period);
	x = "o";
	
	#(`clk_period);
	x = "H";
	#(`clk_period);
	x = "e";
	#(`clk_period);
	x = "l";
	#(`clk_period);
	x = "l";
	#(`clk_period);
	x = "o";
	
	#(`clk_period*5);

	$stop;
end




endmodule 