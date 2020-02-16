module sound_lut(
	clk,
	rst,
	acc
);

input clk;
input rst;
output reg [31:0]acc;

reg [4:0]index;
localparam	L1 = 191130,    M1 = 95546,    H1 = 47823,
				L2 = 170341,    M2 = 85134,    H2 = 42563,
				L3 = 151698,    M3 = 75837,    H3 = 37921,
				L4 = 142183,    M4 = 71581,    H4 = 35793,
				L5 = 127550,    M5 = 63775,    H5 = 31887,
				L6 = 113635,    M6 = 56817,    H6 = 28408,
				L7 = 101234,    M7 = 50617,    H7 = 25309; 
	
always@(posedge clk or negedge rst)
	if(!rst)
		index <= 5'd0;
	else
		index <= index + 1'b1;
		
//always也可以实现组合逻辑，但是在always块中，不论组合逻辑还是时序逻辑都需要将信号定义成reg型
always@(*)
	begin
		case(index)
			0 :acc = M1;
			1 :acc = M2;
			2 :acc = M3;
			3 :acc = M4;
			4 :acc = M5;
			5 :acc = M5;
			6 :acc = M3;
			7 :acc = M1;
			8 :acc = H1;
			9 :acc = H1;
			10:acc = M6;
			11:acc = M4;
			12:acc = M5;
			13:acc = M5;
			14:acc = M3;
			15:acc = M3;
			16:acc = M1;
			17:acc = M2;
			18:acc = M3;
			19:acc = M4;
			20:acc = M5;
			21:acc = M3;
			22:acc = M2;
			23:acc = M1;
			24:acc = M2;
			25:acc = M2;
			26:acc = M3;
			27:acc = M3;
			28:acc = M2;
			29:acc = M2;
			30:acc = M5;
			31:acc = M5;
			default: acc = 32'd0;
		endcase
	end
	
	

endmodule
