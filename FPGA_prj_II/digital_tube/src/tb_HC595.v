`timescale 1ns/1ns
`define clk_period 20

module tb_HC595();

reg clk;
reg rst;
reg [15:0]data_in;
reg en;

wire ds;
wire sh_cp;
wire st_cp;

HC595_Diver HC595_Diver(
	.clk(clk),
	.rst(rst),
	.data_in(data_in),
	.en(en),
	.ds(ds),
	.sh_cp(sh_cp),
	.st_cp(st_cp)
);

initial clk = 1'b1;
always#(`clk_period/2) clk = ~clk;

initial begin
	rst = 1'd0;
	data_in = 16'd0;
	en = 1'd1;
	#(`clk_period*20)
	rst = 1'd1;
	#20000000;
	data_in = 16'h1234;
	#20000000;
	data_in = 16'h5678;
	#20000000;
	$stop;

end

endmodule
