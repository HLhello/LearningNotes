module bcdcnt_top(
	clk,
	rst,
	cin,
	cout,
	q
);

input clk;
input rst;
input cin;

output cout;
output [11:0]q;

wire cout0;
wire cout1;

bcd_counter bcd0(
	.clk(clk),
	.rst(rst),
	.cin(cin),
	.cout(cout0),
	.q(q[3:0])
);
bcd_counter bcd1(
	.clk(clk),
	.rst(rst),
	.cin(cout0),
	.cout(cout1),
	.q(q[7:4])
);
bcd_counter bcd2(
	.clk(clk),
	.rst(rst),
	.cin(cout1),
	.cout(cout),
	.q(q[11:8])
);


endmodule 
