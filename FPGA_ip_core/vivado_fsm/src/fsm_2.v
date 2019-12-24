`timescale 1ns / 1ps

module fsm_2(
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

always@(posedge clk or negedge rst)
	if(!rst)
		state <= s1;
	else 
		begin 
			case(state)
				s1: if(in == 1'b1)
						state <= s2;
					else 
						state <= s3;
				s2: state <= s4;
				s3: state <= s4;
				s4: state <= s1;
				default: ;
			endcase
		end


always@(state)
	case(state)
		s1: out = 1'b1;
        s2: out = 1'b1;
        s3: out = 1'b0;
        s4: out = 1'b0;
	endcase


endmodule
