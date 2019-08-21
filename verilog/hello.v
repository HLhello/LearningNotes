`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/15 08:57:27
// Design Name: 
// Module Name: led
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`define tp 1
module hello(clk, rst, x, out);

	input clk;
	input rst;
	input [7:0]x;
	
	output reg out;
	
	parameter Check_H  = 5'b00001,
	          Check_e  = 5'b00010,
	          Check_la = 5'b00100,
	          Check_lb = 5'b01000,
	          Check_o  = 5'b10000;
	
	reg [4:0]state;
	
	always@(posedge clk or negedge rst)
		if(rst == 0)begin
			state <= Check_H;
			out <= 1'b0;
		end
		else begin
		case(state)
			Check_H : begin 
				if(x == "H")
					state <= Check_e;
				else 
					state <= Check_H;
				end
			Check_e : begin
				if(x == "e")
					state <= Check_la;
				else
					state <= Check_H;
				end
			Check_la: begin
				if(x == "l")
					state <= Check_lb;
				else
					state <= Check_H;
				end
			Check_lb: begin
				if(x == "l")
					state <= Check_o;
				else
					state <= Check_H;				
				end
			Check_o : begin 			
					if(x == "o")
					begin
						state <= Check_H;
						out <= #`tp ~out;
					end
					else begin
						state <= Check_H;
						out <= out;
					end
				end
			default :state <= Check_H;
		endcase
		end
		//为什么我的状态总是延后一拍时钟，但是输出反转的时间是对的
endmodule
