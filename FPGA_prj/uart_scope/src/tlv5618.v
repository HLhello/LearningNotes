module tlv5618(
	clk,
	rst,
	
	div_parm,
	dac_data,
	en_conv,
	conv_done,
	dac_state,
	
	cs_n,
	sclk,
	din
);

input clk;
input rst;

input [7:0]div_parm;
input [15:0]dac_data;

input en_conv;
output conv_done;
output dac_state;

output reg cs_n;
output reg sclk;
output reg din;

reg en;
always@(posedge clk or negedge rst)
	if(!rst)
		en <= 1'd0;
	else if(en_conv)
		en <= 1'd1;
	else if(conv_done)
		en <= 1'd0;
	else 
		en <= en;
reg [7:0]div_cnt;
always@(posedge clk or negedge rst)
	if(!rst)
		div_cnt <= 8'd0;
	else if(en)
		begin
			if(div_cnt == div_parm-1'd1)
				div_cnt <= 8'd0;
			else 
				div_cnt <= div_cnt + 1'd1;
		end
	else 
		div_cnt <= 8'd0;

reg sclk2x;
always@(posedge clk or negedge rst)
	if(!rst)
		sclk2x <= 1'd0;
	else if(en && (div_cnt == div_parm-1'd1))
		sclk2x <= 1'd1;
	else 
		sclk2x <= 1'd0;

reg [5:0]sclk_cnt;
always@(posedge clk or negedge rst)
	if(!rst)
		sclk_cnt <= 6'd0;
	else if(sclk2x && en)
		begin
			if(sclk_cnt == 6'd32)
				sclk_cnt <= 6'd0;
			else 
				sclk_cnt <= sclk_cnt + 1'd1;
		end
	else 
		sclk_cnt <= sclk_cnt;

always@(posedge clk or negedge rst)
	if(!rst)
		cs_n <= 1'd1;
	else if(en && sclk2x)
		cs_n <= sclk_cnt[5];
	else 
		cs_n <= cs_n;
		
assign dac_state = cs_n;
assign conv_done = sclk_cnt[5] && sclk2x;
reg [15:0]r_dac_data;
always@(posedge clk or negedge rst)
	if(!rst)
		begin
			din <= 1'd1;
			sclk <= 1'd0;
			r_dac_data <= 16'd0;
		end
	else 
		begin
			if(en_conv)
				r_dac_data <= dac_data;
			if(!conv_done && sclk2x)
				begin
					if(!sclk_cnt[0])
						begin
							sclk = 1'd1;
							din <= r_dac_data[15];
							r_dac_data <= r_dac_data << 1;
						end
					else 
						sclk <= 1'd0;
				end
		end
	
endmodule 
