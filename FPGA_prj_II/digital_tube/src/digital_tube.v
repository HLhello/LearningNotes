module digital_tube(
	clk,
	rst,
	disp_data,
	en,
	seg,
	sel
);

localparam	num0 = 7'b1000000,
				num1 = 7'b1111001,
				num2 = 7'b0100100,
				num3 = 7'b0110000,
				num4 = 7'b0011001,
				num5 = 7'b0010010,
				num6 = 7'b0000010,
				num7 = 7'b1111000,
				num8 = 7'b0000000,
				num9 = 7'b0010000,
				numa = 7'b0001000,
				numb = 7'b0000011,
				numc = 7'b1000110,
				numd = 7'b0100001,
				nume = 7'b0000110,
				numf = 7'b0001110;

parameter cnt_max = 16'd50000;

input clk;
input rst;
input [31:0]disp_data;
input en;
output reg [6:0]seg;
output reg [7:0]sel;

reg [15:0]cnt;
always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= 16'd0;
	else if(en && cnt<cnt_max-1'd1)
		cnt <= cnt + 1'd1;
	else if(en && cnt==cnt_max-1'd1)
		cnt <= 16'd0;
		
reg full_flag;
always@(posedge clk or negedge rst)
	if(!rst)
		full_flag <= 1'd0;
	else if(cnt == cnt_max - 1'd1)
		full_flag <= 1'd1;
	else
		full_flag <= 1'd0;

always@(posedge clk or negedge rst)
	if(!rst)
		sel <= 8'b0000_0001;
	else if(full_flag)
		sel <= {sel[6:0],sel[7]};
		
reg [3:0]disp_num;		
always@(*)		
	case(sel)
		8'b0000_0001:	disp_num = disp_data[3:0];
		8'b0000_0010:	disp_num = disp_data[7:4];
		8'b0000_0100:	disp_num = disp_data[11:8];
		8'b0000_1000:	disp_num = disp_data[15:12];
		8'b0001_0000:	disp_num = disp_data[19:16];
		8'b0010_0000:	disp_num = disp_data[23:20];
		8'b0100_0000:	disp_num = disp_data[27:24];
		8'b1000_0000:	disp_num = disp_data[31:28];
		default:	disp_num = 4'd0;
	endcase

always@(*)
	case(disp_num)
		4'h0:	seg = num0;
		4'h1:	seg = num1;
		4'h2:	seg = num2;
		4'h3:	seg = num3;
		4'h4:	seg = num4;
		4'h5:	seg = num5;
		4'h6:	seg = num6;
		4'h7:	seg = num7;
		4'h8:	seg = num8;
		4'h9:	seg = num9;
		4'ha:	seg = numa;
		4'hb:	seg = numb;
		4'hc:	seg = numc;
		4'hd:	seg = numd;
		4'he:	seg = nume;
		4'hf:	seg = numf;
	endcase

endmodule 
