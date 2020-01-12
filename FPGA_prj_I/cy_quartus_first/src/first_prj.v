module first_prj(
	clk,
	rst,
	clk_HF
	);
	
input clk;
input rst;

output reg clk_HF;

always@(posedge clk or negedge rst)
	if(!rst)
		clk_HF <= 1'b0;
	else 
		clk_HF <= ~clk_HF;

		
endmodule

