module freq_cnter(
	clk,
	rst,
	mode,
	pause,
	cnt_max,
	cnt_now,
	full_flag
);

input clk;
input rst;
input mode;
input pause;//循环模式下，pause按下为暂停；单次播放模式下，pause按下为播放。按下点平为1
input [31:0]cnt_max;

output [31:0]cnt_now;
output reg full_flag;

reg [31:0]cnt;
reg oneshot;
wire full_flag_r;

assign cnt_now = cnt;
assign full_flag_r = (cnt== cnt_max-1)? 1'b1 : 1'b0;

always@(posedge clk)
	full_flag <= full_flag_r;
	
always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= 32'd0;
	else if(mode)
		begin 
			if((pause==1'b1) && (cnt<cnt_max))
				cnt <= cnt + 1'b1;
			else 
				cnt <= 32'd0;
		end
	else if(!mode)
		begin
			if(oneshot)
				cnt <= cnt + 1'b1;
			else 
				cnt <= 32'd0;
		end

always@(posedge clk or negedge rst)
	if(!rst)
		oneshot <= 1'b0;
	else if(!mode)
		begin
			if(pause)
				oneshot<= 1'b1;
			else if(full_flag_r)
				oneshot <= 1'b0;
			else 
				oneshot <= oneshot;
		end
	else
		oneshot <= 1'b0;

endmodule
