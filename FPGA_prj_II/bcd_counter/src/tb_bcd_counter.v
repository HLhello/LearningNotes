`timescale 1ns/1ps
`define clk_period 20

module tb_bcd_counter();

reg clk;
reg rst;
reg cin;

wire cout;
wire [11:0]q;

initial clk = 1'd1;
always # (`clk_period/2) clk = ~clk;


initial begin
	rst = 1'd1;
	cin = 1'd0;
	#200;
	rst = 1'd0;
	#200;
	rst = 1'd1;
	#200;
	repeat(5000)begin
		cin = 1'd1;
		#`clk_period
		cin = 1'd0;
		#(`clk_period);
	end
	#(`clk_period*10);
	$stop;
	

end


bcdcnt_top bcdcnt_top(
	.clk(clk),
	.rst(rst),
	.cin(cin),
	.cout(cout),
	.q(q)
);

endmodule
