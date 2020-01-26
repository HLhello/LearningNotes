module sound_lut(
	clk,
	rst,
	acc
);

input clk;
input rst;
output reg [31:0]acc;

reg [4:0]index;

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
			0 :acc = 32'd191130;
			1 :acc = 32'd172041;
			2 :acc = 32'd151689;
			3 :acc = 32'd143183;
			4 :acc = 32'd127550;
			5 :acc = 32'd113635;
			6 :acc = 32'd101234;
			7 :acc = 32'd95546;
			8 :acc = 32'd85134;
			9 :acc = 32'd75837;
			10:acc = 32'd71581;
			11:acc = 32'd63775;
			12:acc = 32'd56817;
			13:acc = 32'd50617;
			14:acc = 32'd47823;
			15:acc = 32'd42563;
			16:acc = 32'd37921;
			17:acc = 32'd31887;
			18:acc = 32'd28408;
			19:acc = 32'd25309;
			default: acc = 32'd191130;
		endcase
	end
	
	

endmodule
