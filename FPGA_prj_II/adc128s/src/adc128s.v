module adc128s(
	clk,
	rst,
	channel,
	conv_en,
	dout,
	din,
	cs_n,
	conv_done,
	sclk,
	data,
	adc_state
);

parameter div_parm = 8'd13;//sclk_freq = clk_freq/(div_parm*2)

input clk;
input rst;
input [2:0]channel;
input conv_en;
input dout;
output reg din;
output reg cs_n;
output reg conv_done;
output reg sclk;
output reg [11:0]data;
output adc_state;

assign adc_state = cs_n;

reg [2:0]r_channel;
reg [11:0]r_data;	
reg en;
reg [7:0]div_cnt;
reg sclk2x;
reg [5:0]sclk_cnt;

always@(posedge clk or negedge rst)
	if(!rst)
		r_channel <= 3'd0;
	else if(conv_en)
		r_channel <= channel;
	else 
		r_channel <= r_channel;

always@(posedge clk or negedge rst)
	if(!rst)
		conv_done <= 1'b0;
	else if(en && sclk2x &&(sclk_cnt == 6'd33))
		conv_done <= 1'b1;
	else
		conv_done <= 1'b0;
		
always@(posedge clk or negedge rst)
	if(!rst)
		data <= 12'd0;
	else if(en && sclk2x &&(sclk_cnt == 6'd33))
		data <= r_data;
	else
		data <= data;
		
always@(posedge clk or negedge rst)
	if(!rst)
		en <= 1'd0;
	else if(conv_en)
		en <= 1'd1;
	else if(conv_done)
		en <= 1'd0;
	else
		en <= en;

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

always@(posedge clk or negedge rst)	
	if(!rst)
		sclk2x <= 1'd0;
	else if(en && (div_cnt == div_parm-1'd1))
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
			cs_n <= 1'd1;
			sclk <= 1'd1;
			din <= 1'd1;
		end
	else if(en && sclk2x)
		begin	
			case(sclk_cnt)
				6'd0 :begin cs_n <= 1'd0; end
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
				6'd33:begin cs_n <= 1'd1; end
				default :cs_n <= 1'd1;
			endcase
		end

		
		
endmodule
