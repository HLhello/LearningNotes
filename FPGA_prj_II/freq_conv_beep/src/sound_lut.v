module sound_lut(
	clk,
	rst,
	acc
);

input clk;
input rst;
output reg [31:0]acc;

reg [4:0]index;
localparam	L1 = 191130;    M1 = 95546;    H1 = 47823;
				L2 = 170341;    M2 = 85134;    H2 = 42563;
				L3 = 151698;    M3 = 75837;    H3 = 37921;
				L4 = 142183;    M4 = 71581;    H4 = 35793;
				L5 = 127550;    M5 = 63775;    H5 = 31887;
				L6 = 113635;    M6 = 56817;    H6 = 28408;
				L7 = 101234;    M7 = 50617;    H7 = 25309; 

always@(posedge clk or negedge rst)
	if(!rst)
		index <= 5'd0;
	else if(index >= 5'd20)
		index <= 5'd0;
	else 
		index <= index + 1'b1;
		//always也可以实现组合逻辑，但是在always块中，不论组合逻辑还是时序逻辑都需要将信号定义成reg型
always@(*)
	begin
		case(index)
			0 :acc = L1;
			1 :acc = L2;
			2 :acc = L3;
			3 :acc = L4;
			4 :acc = L5;
			5 :acc = L6;
			6 :acc = L7;
			7 :acc = M1;
			8 :acc = M2;
			9 :acc = M3;
			10:acc = M4;
			11:acc = M5;
			12:acc = M6;
			13:acc = M7;
			14:acc = H1;
			15:acc = H2;
			16:acc = H3;
			17:acc = H4;
			18:acc = H5;
			19:acc = H6;
			20:acc = H7;
			default: acc = 32'd0;
		endcase
	end
	
	

endmodule
