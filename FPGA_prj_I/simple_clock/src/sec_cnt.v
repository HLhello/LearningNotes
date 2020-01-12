module sec_cnt(
	clk,
	rst,
	disp_num
);

parameter per_sec = 25'd24_999999;

input clk;
input rst;

output [15:0]disp_num;

reg [24:0]cnt;
reg [3:0]secs;
reg [3:0]dec_sec;
reg [3:0]mins;
reg [3:0]dec_min;

always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= 25'd0;
	else if(cnt==per_sec)
		cnt <= 25'd0;
	else
		cnt <= cnt + 1'b1;
		
always@(posedge clk or negedge rst)
	if(!rst)
		secs <= 4'd0;
	else if(secs==4'd9 && cnt==per_sec)
		secs <= 4'd0;
	else if(cnt == per_sec)
		secs <= secs+1'b1;

always@(posedge clk or negedge rst)
	if(!rst)
		dec_sec <= 4'd0;
	else if(dec_sec==4'd5 && secs==4'd9 && cnt==per_sec)
		dec_sec <= 4'd0;
	else if(secs == 4'd9 && cnt==per_sec)
		dec_sec <= dec_sec + 1'b1;

always@(posedge clk or negedge rst)
	if(!rst)
		mins <= 4'd0;
	else if(mins==4'd9 && dec_sec==4'd5 && secs==4'd9 && cnt==per_sec)
		mins <= 4'd0;
	else if(dec_sec == 4'd5 && secs==4'd9 && cnt==per_sec)
		mins <= mins + 1'b1;
		
always@(posedge clk or negedge rst)
	if(!rst)
		dec_min <= 4'd0;
	else if(dec_min==4'd5 && mins==4'd9 && dec_sec==4'd5 && secs==4'd9 && cnt==per_sec)
		dec_min <= 4'd0;
	else if(mins==4'd9 && dec_sec==4'd5 && secs==4'd9 && cnt==per_sec)
		dec_min <= dec_min + 1'b1;

assign disp_num = {dec_min,mins,dec_sec,secs};

endmodule

