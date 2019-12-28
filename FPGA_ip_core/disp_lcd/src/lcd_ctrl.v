module lcd_ctrl(
	clk,
	rst,
	lcd_light_en,
	lcd_clk,
	lcd_hsy,
	lcd_vsy,
	lcd_r,
	lcd_g,
	lcd_b
);

input clk;
input rst;

output lcd_light_en;
output lcd_clk;
output lcd_hsy;
output lcd_vsy;
output [4:0]lcd_r;
output [5:0]lcd_g;
output [4:0]lcd_b;

assign lcd_light_en = 1'b1;

reg[1:0]sft_cnt;
always@(posedge clk or negedge rst)
	if(!rst)
		sft_cnt <= 2'd0;
	else 
		sft_cnt <= sft_cnt + 1'b1;
assign lcd_clk = sft_cnt[1];
wire dchange = (sft_cnt == 2'd2);
/*
wire dchange;
assign dchange = (sft_cnt == 2'd2);
*/

reg [8:0]x_cnt;
reg [8:0]y_cnt;
/*A*/
always@(posedge clk or negedge rst)
	if(!rst)
		x_cnt <= 9'd0;
	else if(dchange)
		begin
			if(x_cnt == 9'd407)
				x_cnt <= 9'd0;
			else 
				x_cnt <= x_cnt + 1'b1;
		end
always@(posedge clk or negedge rst)
	if(!rst)
		y_cnt <= 9'd0;
	else if(dchange && (x_cnt == 9'd407))
		begin
			if(y_cnt == 9'd261)
				y_cnt <= 9'd0;
			else 
				y_cnt <= y_cnt + 1'b1;
		end

/*B
always@(posedge clk or negedge rst)
	if(!rst)
		x_cnt <= 9'd0;
	else if(dchange && (x_cnt == 9'd407))
		x_cnt <= 9'd0;
	else if(dchange)
		x_cnt <= x_cnt +1'b1;
always@(posedge clk or negedge rst)
	if(!rst)
		y_cnt <= 9'd0;
	else if(dchange && (x_cnt == 9'd407) && (y_cnt == 9'd261))
		y_cnt <= 9'd0;
	else if(dchange && (x_cnt == 9'd407))
		y_cnt <= y_cnt +1'b1;
*/

reg valid_yr;
always@(posedge clk or negedge rst)
	if(!rst)
		valid_yr <= 1'b0;
	else if(y_cnt == 9'd18)
		valid_yr <= 1'b1;
	else if(y_cnt == 9'd258)
		valid_yr <= 1'b0;

reg validr;
always@(posedge clk or negedge rst)
	if(!rst)
		validr <= 1'b0;
	else if((x_cnt == 9'd67) && valid_yr)
		validr <= 1'b1;
	else if((x_cnt == 9'd387) &&valid_yr)
		validr <= 1'b0;

reg valid;
always@(posedge clk or negedge rst)
	if(!rst)
		valid <= 1'b0;
	else
		valid <= validr;

reg lcd_hsy_r;
always@(posedge clk or negedge rst)
	if(!rst)
		lcd_hsy_r <= 1'b0;
	else if(x_cnt == 9'd0)
		lcd_hsy_r <= 1'b0;
	else if(x_cnt == 9'd30)
		lcd_hsy_r <= 1'b1;
assign lcd_hsy = lcd_hsy_r;

reg lcd_vsy_r;
always@(posedge clk or negedge rst)
	if(!rst)
		lcd_vsy_r <= 1'b0;
	else if(y_cnt == 9'd0)
		lcd_vsy_r <= 1'b0;
	else if(y_cnt == 9'd3)
		lcd_vsy_r <= 1'b1;
assign lcd_vsy = lcd_vsy_r;		

reg [3:0]tmp_cnt;
always@(posedge clk or negedge rst)
	if(!rst)
		tmp_cnt <= 4'd0;
	else if(!validr)
		tmp_cnt <= 4'd0;
	else if(validr && dchange)
		begin
			if(tmp_cnt == 4'd9)
				tmp_cnt <= 4'd0;
			else
				tmp_cnt <= tmp_cnt +1'b1;
		end

reg [15:0]lcd_db_rgb;
always@(posedge clk or negedge rst)
	if(!rst)
		lcd_db_rgb <= 16'd0;
	else if(validr)
		begin
			if((tmp_cnt == 4'd9) && dchange)
				lcd_db_rgb[15:11] <= lcd_db_rgb[15:11] +1'b1;
			else
				lcd_db_rgb <= lcd_db_rgb;
		end
	else 
		lcd_db_rgb <= 16'd0;

assign lcd_r = valid ? lcd_db_rgb[15:11] : 5'b0;
assign lcd_g = valid ? lcd_db_rgb[10:5] : 6'b0;
assign lcd_b = valid ? lcd_db_rgb[4:0] : 5'b0;		
		
		
endmodule
