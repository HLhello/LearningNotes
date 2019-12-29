module key_shake(
	clk,
	rst,
	key_in,
	key_flag,
	key_state
);

parameter IDEL = 4'b0001;
parameter FILTER0 = 4'b0010;
parameter DOWN = 4'b0100;
parameter FILTER1 = 4'b1000;

input clk;
input rst;
input key_in;

output reg key_flag;
output reg key_state;


reg [3:0]state;
reg key_in_r0;
reg key_in_r1;
reg [19:0]cnt;
reg en_cnt;
reg cnt_full;
wire pedge,nedge;

always@(posedge clk)
	key_in_r0 <= key_in;

always@(posedge clk)
	key_in_r1 <= key_in_r0;	

assign pedge = key_in_r0 & (!key_in_r1);  //0110 ~ 1001
assign nedge = (!key_in_r0) & key_in_r1;	//0110 ! 0000

always@(posedge clk or negedge rst)
	if(!rst)
		cnt <=20'd0; 
	else if(en_cnt)
		cnt <= cnt +1'b1;
	else
		cnt <= 20'd0;
		
always@(posedge clk or negedge rst)
	if(!rst)
		cnt_full <= 1'b0;
	else if(cnt == 20'd999999)
		cnt_full <= 1'b1;

always@(posedge clk or negedge rst)
	if(!rst)
		begin 
			state <= IDEL;
			key_flag <= 1'b0;
			key_state <= 1'b1;
			en_cnt <= 1'b0;
		end
	else begin
		case(state)
			IDEL:	
				begin 
					key_flag <= 1'b0;
					if(nedge)begin
						state <= FILTER0;
						en_cnt <= 1'b1;
					end
					else
						state <= IDEL;
				end
			FILTER0:
				if(cnt_full)
					begin
						state <= DOWN;
						key_flag <= 1'b1;
						key_state <= 1'b0;
						en_cnt <= 1'b0;
					end
				else if(pedge)
					begin
						state <= IDEL;
						en_cnt <= 1'b0;
					end
				else 
					state <=FILTER0;
			DOWN:
				begin
					key_flag <= 1'b0;
					if(pedge)
						begin
							state <= FILTER1;
							en_cnt <= 1'b1;
						end
					else
						state <= DOWN;
				end
			FILTER1:
				if(cnt_full)
					begin  
						state <= IDEL;
						key_flag <= 1'b1;
						key_state <= 1'b1;
						en_cnt <= 1'b0;
					end
				else if(nedge)
					begin
						state <= DOWN;
						en_cnt <= 1'b0;
					end
				else 
					state <=FILTER1;
			default: 
				begin 
					state <= IDEL;
					key_flag <= 1'b0;
					key_state <= 1'b1;
					en_cnt <= 1'b0;
				end
		endcase
	end

endmodule

