`timescale 1ns / 1ps

module fsm_1(
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
		begin
			state <= s1;
			out <= 1'b1;
		end
	else
		begin
			case(state)
				s1:
					begin
						if(in == 1'b1)
							begin
								state <= s2;
								out <= 1'b1;
							end
						else 
							begin
								state <= s3;
								out <= 1'b0;
							end
					end
				s2:
					begin 
						state <= s4;
						out <= 1'b1;
					end
				s3:
					begin 
						state <= s4;
						out <= 1'b0;
					end
				s4:
					begin 
						state <= s1;
						out <= 1'b0;
					end
			endcase
		end

endmodule
