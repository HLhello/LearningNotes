module fsm_welcome_IV(
	clk,
	rst,
	data,
	led
);

parameter	IDEL = 5'b0_0000,
				CHECK_H = 5'b0_0001,
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
		pstate <= IDEL;
	else 
		pstate <= nstate;

always@(*)
	case(pstate)
		IDEL :
			begin
				if(data == "H")
					nstate = CHECK_H;
				else 
					nstate = IDEL;
			end
		CHECK_H  :
			begin
				if(data == "e")
					nstate = CHECK_e;
				else 
					nstate = IDEL;
			end
		CHECK_e  :
			begin
				if(data == "l")
					nstate = CHECK_la;
				else 
					nstate = IDEL;
			end
		CHECK_la :
			begin
				if(data == "l")
					nstate = CHECK_lb;
				else 
					nstate = IDEL;
			end
		CHECK_lb :
			begin
				if(data == "o")
					nstate = CHECK_o;
				else 
					nstate = IDEL;
			end
		CHECK_o  : 
			begin 
				if(data == "H")
					nstate = CHECK_H;
				else 
					nstate = IDEL;
			end
		default: nstate = IDEL;
	endcase 
	
always@(posedge clk or negedge rst)
	if(!rst)
		led <= 1'd0;
	else if(pstate == CHECK_lb && data == "o")
		led <= ~led;
		
endmodule 

