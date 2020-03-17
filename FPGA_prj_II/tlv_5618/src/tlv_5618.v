module tlv_5618(
	clk,
	rst,
	start,
	dac_data,
	set_done,
	cs_n,
	din,
	sclk,
	dac_state
);

parameter cnt_max = 3'd2;

input clk;
input rst;
input start;
input [15:0]dac_data;
output reg set_done;
output reg cs_n;
output reg din;
output reg sclk;
output dac_state;

reg en;
reg [2:0]cnt;
reg sclk2x;
reg [5:0]sclk_cnt;

wire trans_done;
assign trans_done = (sclk_cnt == 6'd33) && sclk2x;
assign dac_state = cs_n;

reg [15:0]r_dac_data;
always@(posedge clk or negedge rst)
	if(!rst)
		r_dac_data <= 16'd0;
	else if(start)
		r_dac_data <= dac_data;
	else 
		r_dac_data <= r_dac_data;

always@(posedge clk or negedge rst)
	if(!rst)
		en <= 1'd0;
	else if(start)
		en <= 1'd1;
	else if(trans_done)
		en <= 1'd0;

always@(posedge clk or negedge rst)
	if(!rst)
		set_done <= 1'd0;
	else if(trans_done)
		set_done <= 1'd1;
	else 
		set_done <= 1'd0;
	
always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= 3'd0;
	else if(en) 
		begin
			if(cnt == cnt_max-1'd1)
				cnt <= 3'd0;
			else 
				cnt <= cnt + 1'd1;
		end
	else 
		cnt <= 3'd0;

always@(posedge clk or negedge rst)
	if(!rst)
		sclk2x <= 1'd0;
	else  if(en && (cnt == cnt_max-1'd1))
		sclk2x <= 1'd1;
	else 
		sclk2x <= 1'd0;

always@(posedge clk or negedge rst)	
	if(!rst)
		sclk_cnt <= 6'd0;
	else if(sclk2x && en)
		begin
			if(sclk_cnt == 6'd33)
				sclk_cnt <= 6'd0;
			else
				sclk_cnt <= sclk_cnt + 1'd1;
		end
	else
		sclk_cnt <= sclk_cnt;


		
always@(posedge clk or negedge rst)
	if(!rst)
		begin
			din <= 1'd1;
			sclk <= 1'd0;
			cs_n <= 1'd1;
		end
	else if(!set_done && sclk2x)begin
		case(sclk_cnt)
			6'd0 : begin din <= r_dac_data[15]; sclk <= 1'd1; cs_n <= 1'd0; end
			6'd2 : begin din <= r_dac_data[14]; sclk <= 1'd1; end
			6'd4 : begin din <= r_dac_data[13]; sclk <= 1'd1; end
			6'd6 : begin din <= r_dac_data[12]; sclk <= 1'd1; end
			6'd8 : begin din <= r_dac_data[11]; sclk <= 1'd1; end
			6'd10: begin din <= r_dac_data[10]; sclk <= 1'd1; end
			6'd12: begin din <= r_dac_data[9] ; sclk <= 1'd1; end
			6'd14: begin din <= r_dac_data[8] ; sclk <= 1'd1; end
			6'd16: begin din <= r_dac_data[7] ; sclk <= 1'd1; end
			6'd18: begin din <= r_dac_data[6] ; sclk <= 1'd1; end
			6'd20: begin din <= r_dac_data[5] ; sclk <= 1'd1; end
			6'd22: begin din <= r_dac_data[4] ; sclk <= 1'd1; end
			6'd24: begin din <= r_dac_data[3] ; sclk <= 1'd1; end
			6'd26: begin din <= r_dac_data[2] ; sclk <= 1'd1; end
			6'd28: begin din <= r_dac_data[1] ; sclk <= 1'd1; end
			6'd30: begin din <= r_dac_data[0] ; sclk <= 1'd1; end
			
			1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31:
				begin
					sclk <= 1'd0;
				end
			
			6'd32: sclk <= 1'd1;
			6'd33: cs_n <= 1'd1;
			
			default:;
		endcase
	end


endmodule 
