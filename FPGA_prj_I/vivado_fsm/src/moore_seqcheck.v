`timescale 1ns / 1ps
/*
Moore sequence check 输出取决于当前状态  
*/
module moore_seqcheck(
    clk,
    rst,
	din,
	dout
    );

parameter	s0 = 3'b000,
			s1 = 3'b001,
			s2 = 3'b010,
			s3 = 3'b011,
			s4 = 3'b100;

input wire clk;
input wire rst;
input wire din;
output reg dout;

reg [1:0] pstate;
reg [1:0] nstate;

always@(posedge clk or negedge rst)
	if(!rst)
		pstate <= s0;
	else 
		pstate <= nstate;

always@(*)
	case(pstate)
		s0:
			if(din==1)
				nstate <= s1;
			else
				nstate <= s0;
		s1:
			if(din==1)
				nstate <= s2;
			else
				nstate <= s0;
		s2:
			if(din==0)
				nstate <= s3;
			else
				nstate <= s2;
		s3:
			if(din==1)
				nstate <= s4;
			else
				nstate <= s0;
		s4:
			if(din==0)
				nstate <= s0;
			else
				nstate <= s2;
		default: nstate <= s0;
	endcase 

always@(pstate)
	if(pstate == s4)
		dout <= 1'b1;
	else 
		dout <= 1'b0;


endmodule
