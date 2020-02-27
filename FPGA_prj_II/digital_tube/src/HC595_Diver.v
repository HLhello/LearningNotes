module HC595_Diver(
	clk,
	rst,
	data_in,
	en,
	ds,
	sh_cp,
	st_cp
);

parameter cnt_max = 2'd3;
input clk;
input rst;
input [15:0]data_in;
input en;
output reg ds;
output reg sh_cp;
output reg st_cp;

reg [15:0]data;
always@(posedge clk or negedge rst)
	if(!rst)
		data <= 16'd0;
	else if(en)
		data <= data_in;
	else 
		data <= data;

reg [1:0]div_cnt;
always@(posedge clk or negedge rst)
	if(!rst)
		div_cnt <= 2'd0;
	else
		div_cnt <= div_cnt + 1'd1;

wire sck_pluse;
assign sck_pluse = (div_cnt == cnt_max);

reg [4:0]sck_cnt;
always@(posedge clk or negedge rst)
	if(!rst)
		sck_cnt <= 5'd0;
	else if(sck_pluse)
		sck_cnt <= sck_cnt +1'b1;
	else 
		sck_cnt <= sck_cnt;
		
always@(posedge clk or negedge rst)
	if(!rst)
		begin
			sh_cp <= 1'b0;
			st_cp <= 1'b0;
			ds <= 1'b0;
		end
	else begin
		case(sck_cnt)
			5'd0 : begin sh_cp <= 1'b0; st_cp <= 1'b1; ds <= data[15];end
			5'd1 : begin sh_cp <= 1'b1; st_cp <= 1'b0; end
			5'd2 : begin sh_cp <= 1'b0; ds <= data[14];end
			5'd3 : begin sh_cp <= 1'b1; end
			5'd4 : begin sh_cp <= 1'b0; ds <= data[13];end
			5'd5 : begin sh_cp <= 1'b1; end
			5'd6 : begin sh_cp <= 1'b0; ds <= data[12];end
			5'd7 : begin sh_cp <= 1'b1; end
			5'd8 : begin sh_cp <= 1'b0; ds <= data[11];end
			5'd9 : begin sh_cp <= 1'b1; end
			5'd10: begin sh_cp <= 1'b0; ds <= data[10];end
			5'd11: begin sh_cp <= 1'b1; end
			5'd12: begin sh_cp <= 1'b0; ds <= data[9];end
			5'd13: begin sh_cp <= 1'b1; end
			5'd14: begin sh_cp <= 1'b0; ds <= data[8];end
			5'd15: begin sh_cp <= 1'b1; end
			5'd16: begin sh_cp <= 1'b0; ds <= data[7];end
			5'd17: begin sh_cp <= 1'b1; end
			5'd18: begin sh_cp <= 1'b0; ds <= data[6];end
			5'd19: begin sh_cp <= 1'b1; end
			5'd20: begin sh_cp <= 1'b0; ds <= data[5];end
			5'd21: begin sh_cp <= 1'b1; end
			5'd22: begin sh_cp <= 1'b0; ds <= data[4];end
			5'd23: begin sh_cp <= 1'b1; end
			5'd24: begin sh_cp <= 1'b0; ds <= data[3];end
			5'd25: begin sh_cp <= 1'b1; end
			5'd26: begin sh_cp <= 1'b0; ds <= data[2];end
			5'd27: begin sh_cp <= 1'b1; end
			5'd28: begin sh_cp <= 1'b0; ds <= data[1];end
			5'd29: begin sh_cp <= 1'b1; end
			5'd30: begin sh_cp <= 1'b0; ds <= data[0];end
			5'd31: begin sh_cp <= 1'b1; end
		endcase
	end
endmodule 
