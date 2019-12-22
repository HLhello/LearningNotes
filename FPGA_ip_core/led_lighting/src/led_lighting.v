module led_lighting(
	clk,
	rst,
	led
);
input clk;
input rst;

output reg [7:0]led;

reg [19:0] cnt;
always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= 20'd0;
	else
		cnt <= cnt + 1'b1;


always@(posedge clk or negedge rst)
	if(!rst)
		led <= 8'b1111_1110;
	else if(cnt == 20'hfffff)
		led <= {led[6:0],led[7]};

endmodule
