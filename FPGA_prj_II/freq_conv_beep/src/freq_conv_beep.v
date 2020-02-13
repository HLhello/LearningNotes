module freq_conv_beep(
	clk,
	rst,
	cnt_acc,
	mode,
	cnt_going,
	cnt_now,
	full_flag
);
	
input clk;
input rst;
input [31:0]cnt_acc;
input mode;//计数模式，0单次计数，1循环计数
input cnt_going;//高点平计数，低电平停止计数

output [31:0]cnt_now;//当前计数值
output reg full_flag;

reg [31:0]cnt;//定义一个计数器
reg oneshot;
wire full_flag_r;

assign cnt_now = cnt;
assign full_flag_r =(cnt == cnt_acc-1)? 1'b1 : 1'b0;

always@(posedge clk)
	full_flag <= full_flag_r;

always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= 32'd0;
	else if(mode)
		begin
			if((cnt_going == 1'b1) && (cnt<cnt_acc))
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
			if(cnt_going)
				oneshot <= 1'b1;
			else if(full_flag_r)
				oneshot <= 1'b0;
			else 	
				oneshot <= oneshot;
		end
	else 
		oneshot <= 1'b0;
	

endmodule 