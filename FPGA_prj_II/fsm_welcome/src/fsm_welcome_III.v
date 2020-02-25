module fsm_welcome_III(
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
reg [4:0] pstate;
reg [4:0] nstate;

always@(posedge clk or negedge rst)
	if(!rst)
		pstate <= CHECK_H;
	else 
		pstate <= nstate;

always@(*)
	case(pstate)
		CHECK_H  :
			begin
				if(data == "H")
					nstate = CHECK_e;
				else 
					nstate = CHECK_H;
			end
		CHECK_e  :
			begin
				if(data == "e")
					nstate = CHECK_la;
				else 
					nstate = CHECK_H;
			end
		CHECK_la :
			begin
				if(data == "l")
					nstate = CHECK_lb;
				else 
					nstate = CHECK_H;
			end
		CHECK_lb :
			begin
				if(data == "l")
					nstate = CHECK_o;
				else 
					nstate = CHECK_H;
			end
		CHECK_o  : nstate = CHECK_H;
		default: nstate = CHECK_H;
	endcase 
	
always@(posedge clk or negedge rst)
	if(!rst)
		led <= 1'd0;
	else if(pstate == CHECK_o && data == "o")
		led <= ~led;
		
endmodule 

