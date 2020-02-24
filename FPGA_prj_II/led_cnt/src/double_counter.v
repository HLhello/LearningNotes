module double_counter(
	clk,
	cin,
	cout,
	q
);

input clk;
input cin;

output cout;
output [7:0]q;

wire low_cout;

cnt cnt0 (
	.cin ( cin ),
	.clock ( clk ),
	.cout ( low_cout ),
	.q ( q[3:0] )
	);
	
cnt cnt1 (
	.cin ( low_cout ),
	.clock ( clk ),
	.cout ( cout ),
	.q ( q[7:4] )
	);
	


endmodule
