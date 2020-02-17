module sound_lut(
	clk,
	rst,
	cnt_max
);

input clk;
input rst;

output reg [31:0]cnt_max;

localparam	L1 = 191130,    M1 = 95546,    H1 = 47823,
				L2 = 170341,    M2 = 85134,    H2 = 42563,
				L3 = 151698,    M3 = 75837,    H3 = 37921,
				L4 = 142183,    M4 = 71581,    H4 = 35793,
				L5 = 127550,    M5 = 63775,    H5 = 31887,
				L6 = 113635,    M6 = 56817,    H6 = 28408,
				L7 = 101234,    M7 = 50617,    H7 = 25309; 
reg [7:0]addr;
wire [4:0]cursor;

always@(posedge clk or negedge rst)
	if(!rst)
		addr <= 8'd0;
	else if(addr <= 8'd95)
		addr <= 8'd0;
	else
		addr <= addr + 1'b1;
music_note note(
	.address(addr),
	.clock(clk),
	.q(cursor)
	);

always@(*)
	begin 
		case(cursor)
			1 :cnt_max = M1;
			2 :cnt_max = M2;
			3 :cnt_max = M3;
			4 :cnt_max = M4;
			5 :cnt_max = M5;
			6 :cnt_max = M6;
			7 :cnt_max = M7;
			8 :cnt_max = H1;
			9 :cnt_max = H2;
			10:cnt_max = H3;
			11:cnt_max = H4;
			12:cnt_max = H5;
			13:cnt_max = H6;
			14:cnt_max = H7;
			15:cnt_max = L1;
			16:cnt_max = L2;
			17:cnt_max = L3;
			18:cnt_max = L4;
			19:cnt_max = L5;
			20:cnt_max = L6;
			21:cnt_max = L7;
			default:cnt_max = 0;
		endcase
	end
		
endmodule
