module pmw_beep(
	clk,
	rst,
	beep
);

input clk;
input rst;

output reg beep;

reg [19:0]cnt;

always@(posedge clk or negedge rst)
	if(!rst)
		cnt = 20'b0;
	else if(cnt == 20'd999_999)
		cnt = 20'b0;
	else
		cnt = cnt +1'b1;

always@(posedge clk or negedge rst)
	if(!rst)
		beep = 1'b0;
	else if(cnt <= 20'd75842)
		beep = 1'b0;
	else
		beep = 1'b1;

endmodule
