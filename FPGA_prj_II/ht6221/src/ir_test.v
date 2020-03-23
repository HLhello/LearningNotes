module ir_test(
	clk,
	rst,
	iir,
	irdata,
	iraddr,
	get_flag
);

input clk;
input rst;
input iir;
output [15:0]irdata;
output [15:0]iraddr;
output get_flag;


ir_decoder ir_decoder(
	.Clk(clk),
	.Rst_n(rst),
	.iIR(iir),
	.irData(irdata),
	.irAddr(iraddr),
	.Get_Flag(get_flag)
);

issp	issp (
	.probe ( {irdata,iraddr} ),
	.source (  )
	);

endmodule


