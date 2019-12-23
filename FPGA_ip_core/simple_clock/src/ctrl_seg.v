module ctrl_seg(
	clk,
	rst,
	disp_num,
	sel_digit,
	sel_seg
);

parameter	NUM0 = 8'h3f,
				NUM1 = 8'h06,
				NUM2 = 8'h5b,
				NUM3 = 8'h4f,
				NUM4 = 8'h66,
				NUM5 = 8'h6d,
				NUM6 = 8'h7d,
				NUM7 = 8'h07,
				NUM8 = 8'h7f,
				NUM9 = 8'h6f;

parameter	CSN = 4'b1111,
				CS0 = 4'b1110, 
				CS1 = 4'b1101,
				CS2 = 4'b1011,
				CS3 = 4'b0111;
			 

			 
input clk;
input rst;
input [15:0]disp_num;

output reg [3:0]sel_digit;
output reg [7:0]sel_seg;

reg [7:0]div_cnt;
reg [3:0]current_dispnum;

always@(posedge clk or negedge rst)
	if(!rst)
		div_cnt <= 8'd0;
	else 
		div_cnt <= div_cnt +1'b1;

always@(posedge clk or negedge rst)
	if(!rst)
		current_dispnum <= 4'd0;
	else begin
		case(div_cnt[7:6])
			2'b00: current_dispnum <= disp_num[3:0];
			2'b01: current_dispnum <= disp_num[7:4];
			2'b10: current_dispnum <= disp_num[11:8];
			2'b11: current_dispnum <= disp_num[15:12];
			default: current_dispnum <= 4'd0;
		endcase
	end

always@(posedge clk or negedge rst)
	if(!rst)
		sel_seg <= 8'd0;
	else begin
		case(current_dispnum)
			4'd0: sel_seg <= NUM0;
			4'd1: sel_seg <= NUM1;
			4'd2: sel_seg <= NUM2;
			4'd3: sel_seg <= NUM3;
			4'd4: sel_seg <= NUM4;
			4'd5: sel_seg <= NUM5;
			4'd6: sel_seg <= NUM6;
			4'd7: sel_seg <= NUM7;
			4'd8: sel_seg <= NUM8;
			4'd9: sel_seg <= NUM9;
			default: sel_seg <= NUM0;
		endcase
	end
	
always@(posedge clk or negedge rst)
	if(!rst)
		sel_digit <= 4'd0;
	else begin
		case(div_cnt[7:6])
			2'b00: sel_digit <= CS0;
			2'b01: sel_digit <= CS1;
			2'b10: sel_digit <= CS2;
			2'b11: sel_digit <= CS3;
			default: sel_digit <= CSN;
		endcase 	
	end
endmodule

     