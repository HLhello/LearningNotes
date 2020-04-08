module key_filter(
	clk,
	rst,
	key_in,
	key_flag,
	key_state
);

parameter cnt_max = 20'd999_999;

input clk;
input rst;
input key_in;
output reg key_flag;
output reg key_state;

localparam	IDEL = 4'b0001,
				FILTER0 = 4'b0010,
				DOWN = 4'b0100,
				FILTER1 = 4'b1000;

//边沿检测
reg key_in_tmp1, key_in_tmp2;
always@(posedge clk)
	key_in_tmp1 <= key_in;
always@(posedge clk)
	key_in_tmp2 <= key_in_tmp1;
wire pedge, nedge;
assign pedge = key_in_tmp1 && !key_in_tmp2;
assign nedge = key_in_tmp2 && !key_in_tmp1;

//抖动计时
reg [19:0]cnt;
reg cnt_en;
reg cnt_full;
always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= 20'd0;
	else if(cnt_en)
		cnt <= cnt + 1'd1;
	else 
		cnt <= 20'd0;
		
always@(posedge clk or negedge rst)
	if(!rst)
		cnt_full <= 1'd0;
	else if(cnt == cnt_max)
		cnt_full <= 1'd1;
	else 
		cnt_full <= 1'd0;

//状态转移
reg [3:0]state;
always@(posedge clk or negedge rst)
	if(!rst)
		begin
			state <= IDEL;
			cnt_en <= 1'd0;
			key_flag <= 1'd0;
			key_state <= 1'd1;
		end
	else begin
		case(state)
			IDEL:
				begin
					key_flag <= 1'd0;
					if(nedge)
						begin
							state <= FILTER0;
							cnt_en <= 1'd1;
						end
					else
						state <= IDEL;
				end
			FILTER0:
				if(cnt_full)
					begin
						state <= DOWN;
						cnt_en <= 1'd0;
						key_flag <= 1'd1;
						key_state <= 1'd0;
					end
				else if(pedge)
					begin
						state <= IDEL;
						cnt_en <= 1'd0;
					end
				else 
					state <= FILTER0;
			DOWN:
				begin
					key_flag <= 1'd0;
					if(pedge)
						begin
							state <= FILTER1;
							cnt_en <= 1'd1;
						end
					else 
						state <= DOWN;
				end
			FILTER1:
				if(cnt_full)
					begin
						state <= IDEL;
						cnt_en <= 1'd0;
						key_flag <= 1'd1;
						key_state <= 1'd1;
					end
				else if(nedge)
					begin
						state <= DOWN;
						cnt_en <= 1'd0;
					end
				else 
					state <= FILTER1;
			default:
				begin
					state <= IDEL;
					cnt_en <= 1'd0;
					key_flag <= 1'd0;
					key_state <= 1'd1;
				end
		endcase
	end

endmodule 
