module adc128s022(
	clk,
	rst,
	channel,
	data,
	en_conv,
	conv_done,
	adc_state,
	div_parm,
	//四线spi接口
	sclk,
	dout,
	din,
	cs_n
);

input clk;
input rst;

input [2:0]channel;
output reg [11:0]data;

input en_conv;
output reg conv_done;
output adc_state;
input [7:0]div_parm;

output reg sclk;
output reg cs_n;
input dout;
output reg din;


reg [2:0]r_channel;
always@(posedge clk or negedge rst)
	if(!rst)
		r_channel <= 3'd0;
	else if(en_conv)
		r_channel <= channel;
	else
		r_channel <= r_channel;

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
		
/* 线性序列机
 * |--------序列时钟
 * |--------序列计数
 * |--------case语句
 */

reg [7:0]div_cnt;
always@(posedge clk or negedge rst)
	if(!rst)
		div_cnt <= 8'd0;
	else if(en)
		begin
			if(div_cnt == (div_parm-1'd1))
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
	else if(en && (div_cnt == (div_parm-1'd1)))
		sclk2x <= 1'd1;
	else 
		sclk2x <= 1'd0;

reg [5:0]sclk_cnt;
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
		
reg [11:0]r_data;
always@(posedge clk or negedge rst)
	if(!rst)
		begin
			cs_n <= 1'd1;
			sclk <= 1'd1;
			din <= 1'd1;			
		end
	else if(en && sclk2x)
		begin
			case(sclk_cnt)
				6'd0: begin cs_n <= 1'd0; end
				6'd1: begin sclk <= 1'd0; din <= 1'd0; end
				6'd2: begin sclk <= 1'd1; end
				6'd3: begin sclk <= 1'd0; end
				6'd4: begin sclk <= 1'd1; end
				6'd5: begin sclk <= 1'd0; din <= r_channel[2]; end
				6'd6: begin sclk <= 1'd1; end 
				6'd7: begin sclk <= 1'd0; din <= r_channel[1]; end 
				6'd8: begin sclk <= 1'd1; end 
				6'd9: begin sclk <= 1'd0; din <= r_channel[0]; end
				6'd10, 6'd12, 6'd14, 6'd16, 6'd18, 6'd20, 6'd22, 6'd24, 6'd26, 6'd28, 6'd30, 6'd32:
						begin sclk <= 1'd1; r_data <= {r_data[10:0],dout}; end
				6'd11, 6'd13, 6'd15, 6'd17, 6'd19, 6'd21, 6'd23, 6'd25, 6'd27, 6'd29, 6'd31:
						begin sclk <= 1'd0; end
				6'd33: cs_n <= 1'd1;
				default: cs_n <= 1'd1;
			endcase
		end
	else 
		cs_n <= 1'd1;

always@(posedge clk or negedge rst)
	if(!rst)
		begin
			data <= 12'd0;
			conv_done <= 1'd0;
		end
	else if(en && sclk2x && (sclk_cnt == 6'd33))
		begin
			data <= r_data;
			conv_done <= 1'd1;
		end
	else 
		begin
			data <= data;
			conv_done <= 1'd0;
		end
		
assign adc_state = cs_n;

	
endmodule 
