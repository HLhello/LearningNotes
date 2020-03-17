module adc128s(
	clk,
	rst,
	div_parm,
	channel,
	en_conv,
	dout,
	din,
	cs_n,
	adc_state,
	conv_done,
	sclk,
	data
);

input clk;
input rst;
input [7:0]div_parm;//sclk_freq = clk_freq/(div_parm*2)
input [2:0]channel;
input en_conv;
input dout;
output reg din;
output reg cs_n;
output adc_state;
output reg conv_done;
output reg sclk;
output reg [11:0]data;

assign adc_state = cs_n;

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

reg [4:0]div_cnt;
always@(posedge clk or negedge rst)
	if(!rst)
		div_cnt <= 5'd0;
	else if(en)
		begin
			if(div_cnt == div_parm-1'd1)
				div_cnt <= 5'd0;
			else 
				div_cnt <= div_cnt + 1'd0;
		end
	else 
		div_cnt <= 5'd0;

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
			if(sclk_cnt == 6'd33)
				sclk_cnt <= 6'd0;
			else 
				sclk_cnt <= sclk_cnt + 1'd1;
		end
	else 
		sclk_cnt <= sclk_cnt;

always@(posedge clk or negedge rst)
	if(!rst)
		cs_n <= 1'd1;
	else if(en && sclk_cnt < 6'd33)
		cs_n <= 1'd0;
	else 
		cs_n <= 1'd1;
reg [11:0]r_data;	
always@(posedge clk or negedge rst)
	if(!rst)
		begin
			sclk <= 1'd1;
			din <= 1'd1;
		end
	else if(en && sclk2x)
		begin	
			case(sclk_cnt)
				6'd1 :begin sclk <= 1'd0; din <= 1'd0; end
				6'd2 :begin sclk <= 1'd1;  end
				6'd3 :begin sclk <= 1'd0;  end
				6'd4 :begin sclk <= 1'd1;  end
				6'd5 :begin sclk <= 1'd0; din <= r_channel[2]; end
				6'd6 :begin sclk <= 1'd1;  end
				6'd7 :begin sclk <= 1'd0; din <= r_channel[2]; end
				6'd8 :begin sclk <= 1'd1;  end
				6'd9 :begin sclk <= 1'd0; din <= r_channel[2]; end
				6'd10:begin sclk <= 1'd1; r_data <= {r_data[10:0],dout}; end
				6'd11:begin sclk <= 1'd0;  end
				6'd12:begin sclk <= 1'd1; r_data <= {r_data[10:0],dout}; end
				6'd13:begin sclk <= 1'd0;  end
				6'd14:begin sclk <= 1'd1; r_data <= {r_data[10:0],dout}; end
				6'd15:begin sclk <= 1'd0;  end
				6'd16:begin sclk <= 1'd1; r_data <= {r_data[10:0],dout}; end
				6'd17:begin sclk <= 1'd0;  end
				6'd18:begin sclk <= 1'd1; r_data <= {r_data[10:0],dout}; end
				6'd19:begin sclk <= 1'd0;  end
				6'd20:begin sclk <= 1'd1; r_data <= {r_data[10:0],dout}; end
				6'd21:begin sclk <= 1'd0;  end
				6'd22:begin sclk <= 1'd1; r_data <= {r_data[10:0],dout}; end
				6'd23:begin sclk <= 1'd0;  end
				6'd24:begin sclk <= 1'd1; r_data <= {r_data[10:0],dout}; end
				6'd25:begin sclk <= 1'd0;  end
				6'd26:begin sclk <= 1'd1; r_data <= {r_data[10:0],dout}; end
				6'd27:begin sclk <= 1'd0;  end
				6'd28:begin sclk <= 1'd1; r_data <= {r_data[10:0],dout}; end
				6'd29:begin sclk <= 1'd0;  end
				6'd30:begin sclk <= 1'd1; r_data <= {r_data[10:0],dout}; end
				6'd31:begin sclk <= 1'd0;  end
				6'd32:begin sclk <= 1'd1; r_data <= {r_data[10:0],dout}; end
				6'd33:begin sclk <= 1'd0;  end
				default : ;
			endcase
		end
always@(posedge clk or negedge rst)
	if(!rst)
		begin
			data <= 12'd0;
			conv_done <= 1'b0;
		end
	else if(en && sclk2x &&(sclk_cnt == 6'd33))
		begin
			data <= r_data;
			conv_done <= 1'b1;
		end
	else 
		begin
			data <= data;
			conv_done <= 1'b0;
		end
		
		
endmodule
