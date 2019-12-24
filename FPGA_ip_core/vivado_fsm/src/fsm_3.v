`timescale 1ns / 1ps

module fsm_3(
    clk,
    rst,
    in,
    out
);

parameter	s1 = 2'b00,
			s2 = 2'b01,
			s3 = 2'b10,
			s4 = 2'b11;


input clk;
input rst;
input in;
output reg out;

reg [1:0]state;
reg [1:0]nstate;

always@(posedge clk or negedge rst)
	if(!rst)
		state <= s1;
	else 
		state <= nstate;

always@(state or in)
	case(state)
		s1: if(in == 1'b1)
				nstate = s2;
			else 
				nstate = s3;
		s2: nstate = s4;
		s3: nstate = s4;
		s4: nstate = s1;
	endcase

always@(state)
	case(state)
		s1: out = 1'b1;
        s2: out = 1'b1;
        s3: out = 1'b0;
        s4: out = 1'b0;
	endcase














endmodule
