module bcd_counter(
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

reg [3:0]cnt;
/*
always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= 4'd0;
	else if(cin == 1'b1 && cnt < 4'd9)
		cnt <= cnt + 1'b1;
	else if(cin == 1'b1 && cnt == 4'd9)
		cnt <= 4'd0;
*/
always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= 4'd0;
	else if(cin == 1'b1)begin
		if(cnt == 4'd9)
			cnt <= 4'd0;
		else 
			cnt <= cnt + 1'b1;
	end
	else
		cnt <= cnt;
		
assign cout = (cin == 1'b1 && cnt == 4'd9);
assign q = cnt;

endmodule
