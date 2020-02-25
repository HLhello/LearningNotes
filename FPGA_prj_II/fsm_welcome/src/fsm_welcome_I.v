module fsm_welcome_I(
	clk,
	rst,
	data,
	led
);

parameter	CHECK_H = 5'b0_0001,
				CHECK_e = 5'b0_0010,
				CHECK_la = 5'b0_0100,
				CHECK_lb = 5'b0_1000,
				CHECK_o = 5'b1_0000;			
				
input clk;
input rst;
input [7:0]data;

output reg led;

reg [4:0] state;

always@(posedge clk or negedge rst)
	if(!rst)
		begin
			state <= CHECK_H;
			led <= 1'd0;
		end
	else begin 
		case(state)
			CHECK_H  :
				begin
					if(data == "H")
						state <= CHECK_e;
					else 
						state <= CHECK_H;
				end
			CHECK_e  :
				begin
					if(data == "e")
						state <= CHECK_la;
					else 
						state <= CHECK_H;
				end
			CHECK_la :
				begin
					if(data == "l")
						state <= CHECK_lb;
					else 
						state <= CHECK_H;
				end
			CHECK_lb :
				begin
					if(data == "l")
						state <= CHECK_o;
					else 
						state <= CHECK_H;
				end
		   CHECK_o  :
				begin
					state <= CHECK_H;
					if(data == "o")
						led <= ~led;
					else 
						led <= led;
				end 
			default:
				begin
					state <= CHECK_H;
					led <= led;
				end
		endcase 
	end
	
endmodule 

