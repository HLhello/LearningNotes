module key_filter(
	clk,
	rst,
	key_in,
	key_flag,
	key_state
);

parameter	IDLE = 4'b0001,
				FILTER0 = 4'b0010,
				DOWN = 4'b0100,
				FILTER1 = 4'b1000;

parameter cnt_max = 24'd1_000_000;
				
input clk;
input rst;
input key_in;
output reg key_flag;
output reg key_state;

reg [23:0]cnt;
reg key_in_r1,key_in_r2;
reg full_flag;
reg [3:0]state;

wire nedge,pedge;

always@(posedge clk)
	key_in_r1 <= key_in;
always@(posedge clk)
	key_in_r2 <= key_in_r1;	

assign nedge = !key_in_r1 && key_in_r2;
assign pedge = key_in_r1 && !key_in_r2;	
	
always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= 24'd0;
	else if((pedge || nedge) && (cnt < cnt_max-1'd1))
		cnt <= cnt + 1'd1;
	else 
		cnt <= 24'd0;

always@(posedge clk or negedge rst)
	if(!rst)
		full_flag <= 1'd0;
	else if(cnt == cnt_max-1'd1)
		full_flag <= 1'd1;
	else 
		full_flag <= 1'd0;
		

always@(posedge clk or negedge rst)
	if(!rst)
		state <= IDLE;
	else begin
		case(state)
			IDLE:
				begin 
					if(nedge)
						state <= FILTER0;
					else 
						state <= IDLE;
				end
			FILTER0:
				begin 
					if(full_flag)
						state <= DOWN;
					else if(pedge)
						state <= IDLE;
					else 
						state <= FILTER0;
				end
			DOWN:
				begin 
					if(pedge)
						state <= FILTER1;
					else 
						state <= DOWN;
				end
			FILTER1:
				begin 
					if(full_flag)
						state <= IDLE;
					else if(nedge)
						state <= DOWN;
					else 
						state <= FILTER1;
				end
			default: state <= IDLE;
		endcase 
	end
always@(posedge clk or negedge rst)
	if(!rst)
		key_flag <= 1'd0;
	else if(state == FILTER0 && full_flag)
		key_flag <= 1'd1;
	else 
		key_flag <= 1'd0;

always@(posedge clk or negedge rst)
	if(!rst)
		key_state <= 1'd0;
	else if(state == IDLE || state == FILTER0)
		key_state <= 1'd0;
	else if(state == DOWN || state == FILTER1)
		key_state <= 1'd1;

		
endmodule 
